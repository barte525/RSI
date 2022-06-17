//
//  EditProfileView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 14/04/2022.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                TextField("Name", text: $userStateViewModel.name)
                TextField("Surname", text: $userStateViewModel.surname)
            }
        }
        .padding(.top, 10)
        .background(Color("Background"))
        .navigationTitle("Edit profile")
        .navigationBarItems(trailing: Button("Save") {
            userStateViewModel.updateUser()
            if !userStateViewModel.areIncorrectData {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .alert(isPresented: $userStateViewModel.areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text("Please enter valid data"), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
