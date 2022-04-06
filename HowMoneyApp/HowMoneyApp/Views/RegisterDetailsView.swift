//
//  RegisterDetailsView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 06/04/2022.
//

import SwiftUI

struct RegisterDetailsView: View {
    @Binding var emailTextField: String
    @Binding var passwordTextField: String
    @Binding var repeatedPasswordTextField: String
    @State var nameTextField: String = ""
    @State var surnameTextField: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                UnderlineTextField(textFieldTitle: "Email", textField: $emailTextField)
                    .padding(.top, 20)
                UnderlineTextField(textFieldTitle: "Password", textField: $passwordTextField)
                UnderlineTextField(textFieldTitle: "Repeated password", textField: $repeatedPasswordTextField)
                UnderlineTextField(textFieldTitle: "Name", textField: $nameTextField)
                UnderlineTextField(textFieldTitle: "Surname", textField: $surnameTextField)
                Spacer()
                Button {
                    //TODO: register()
                    //1. Passwords are the same - go to next register view
                    //2. Incorrect passwords - Show alert
                } label: {
                    ButtonText(text: "Register")
                }
                Spacer()
            }
            .background(Color("Lavenda"))
            .cornerRadius(30)
            .padding([.leading, .trailing], 40)
            .padding([.top, .bottom], 20)
        }
        .background(Color("Background"))
    }
}

struct RegisterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterDetailsView(emailTextField: .constant("john.smith@gmail.com"), passwordTextField: .constant("p@ssw0rd"), repeatedPasswordTextField: .constant("p@ssw0rd"))
    }
}
