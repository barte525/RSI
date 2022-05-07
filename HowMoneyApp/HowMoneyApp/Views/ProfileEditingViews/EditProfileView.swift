//
//  EditProfileView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 14/04/2022.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var editProfileViewModel: EditProfileViewModel = .init(userManager: UserManager())
    var user: User
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                TextField("Name", text: $editProfileViewModel.nameTextField)
                TextField("Surname", text: $editProfileViewModel.surnameTextField)
                TextField("Email", text: $editProfileViewModel.emailTextField)
            }
        }
        .padding(.top, 10)
        .background(Color("Background"))
        .navigationTitle("Edit profile")
        .navigationBarItems(trailing: Button("Save") {
            editProfileViewModel.updateUser(user: user)
            if !editProfileViewModel.areIncorrectData {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .alert(isPresented: $editProfileViewModel.areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text("Please enter valid data"), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: UserMock.user1)
    }
}
