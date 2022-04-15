//
//  EditProfileView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 14/04/2022.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var nameTextField: String = ""
    @State var surnameTextField: String = ""
    @State var emailTextField: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                TextField("Name", text: $nameTextField)
                TextField("Surname", text: $surnameTextField)
                TextField("Email", text: $emailTextField)
            }
        }
        .padding(.top, 10)
        .background(Color("Background"))
        .navigationTitle("Edit profile")
        .navigationBarItems(trailing: Button("Save") {
            //TODO: Update profiles data
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
