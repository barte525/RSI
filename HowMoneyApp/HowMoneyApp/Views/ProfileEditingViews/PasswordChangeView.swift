//
//  PasswordChangeView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 14/04/2022.
//

import SwiftUI

struct PasswordChangeView: View {
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    @State var isEnabledTouchID: Bool = false
    @Binding var isShown: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Old password")) {
                    SecureField("Old password", text: $userStateViewModel.oldPasswordTextField)
                }
                
                Section(header: Text("New password")) {
                    SecureField("New password", text: $userStateViewModel.newPasswordTextField)
                    SecureField("Verify", text: $userStateViewModel.repeatedNewPasswordTextField)
                }
                
                Section(header: Text("App Lock")) {
                    Toggle(isOn: $isEnabledTouchID) {
                        Text("Use Touch ID")
                    }
                }
            }
            .padding(.top, 10)
            .background(Color("Background"))
            .navigationTitle("Change password")
            .navigationBarItems(leading: Button("Cancel") {
                isShown.toggle()
            }, trailing: Button("Save") {
                userStateViewModel.changePassword()
                if !userStateViewModel.areIncorrectData {
                    isShown.toggle()
                }
            })
            .alert(isPresented: $userStateViewModel.areIncorrectData) {
                Alert(title: Text("Error occurs"),
                      message: Text(userStateViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
            }
        }
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView(isShown: .constant(true))
    }
}
