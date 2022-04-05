//
//  RegisterView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 05/04/2022.
//

import SwiftUI

struct RegisterView: View {
    @State var emailTextField: String = ""
    @State var passwordTextField: String = ""
    @State var repeatedPasswordTextField: String = ""
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .scaledToFit()
            VStack {
                Text("Register Account")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.top, 40)
                    .frame(minWidth: 150, maxWidth: .infinity)
                UnderlineTextField(textFieldTitle: "Email", textField: $emailTextField)
                UnderlineTextField(textFieldTitle: "Password", textField: $passwordTextField)
                UnderlineTextField(textFieldTitle: "Repeated password", textField: $repeatedPasswordTextField)
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
            .padding([.trailing, .leading], 40)
            .padding(.bottom, 2)
            HStack {
                Text("Already have an account? ")
                    .foregroundColor(.black)
                Button {
                    //TODO: Navigate to LogIn Account View
                } label: {
                    Text("Sign In")
                        .foregroundColor(Color("DarkPurple"))
                        .fontWeight(.semibold)
                }
            }
            .font(.system(size: 16))
            .padding(.bottom, 30)
        }
        .background(Color("Background"))
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
