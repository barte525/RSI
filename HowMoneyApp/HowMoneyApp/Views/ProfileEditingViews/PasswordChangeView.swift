//
//  PasswordChangeView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 14/04/2022.
//

import SwiftUI

struct PasswordChangeView: View {
    
    @Binding var isShown: Bool
    @State var newPasswordTextField: String = ""
    @State var repeatedNewPasswordTextField: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Password", text: $newPasswordTextField)
                TextField("Verify", text: $repeatedNewPasswordTextField)
            }
            .padding(.top, 10)
            .background(Color("Background"))
            .navigationTitle("Change password")
            .navigationBarItems(leading: Button("Cancel") {
                isShown.toggle()
            }, trailing: Button("Save") {
                //TODO: Change password on pressing save button
                isShown.toggle()
            })
        }
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView(isShown: .constant(true))
    }
}
