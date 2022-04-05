//
//  LogInView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 05/04/2022.
//

import SwiftUI

struct LogInView: View {
    @State var emailTextfield: String = ""
    @State var passwordTextfield: String = ""
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .scaledToFit()
            VStack {
                Text("Login Account")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.top, 40)
                    .frame(minWidth: 150, maxWidth: .infinity)
                UnderlineTextField(textFieldTitle: "Email", textField: $emailTextfield)
                UnderlineTextField(textFieldTitle: "Password", textField: $passwordTextfield)
                HStack {
                    Spacer()
                    Button {
                        //TODO: Navgate to forgot password view
                    } label: {
                        Text("Forgot password?")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }.padding([.leading, .trailing], 30)
                
                Spacer()
                Button {
                    //TODO: signIn()
                    //1. Correct email and password - navigate to home tab
                    //2. Incorrect fields - show alert
                } label: {
                    ButtonText(text: "Sign In")
                }
                Spacer()
            }
            .background(Color("Lavenda"))
            .cornerRadius(30)
            .padding([.trailing, .leading], 40)
            .padding(.bottom, 2)
            HStack {
                Text("Don't have an account? ")
                    .foregroundColor(.black)
                Button {
                    //TODO: Navigate to Register Account View
                } label: {
                    Text("Create account")
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

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .previewDevice("iPhone 12")
    }
}
