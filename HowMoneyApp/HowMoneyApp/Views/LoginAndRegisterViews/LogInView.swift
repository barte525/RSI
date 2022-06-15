//
//  LogInView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 05/04/2022.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    
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
                UnderlineTextField(textFieldTitle: "Email", isSecured: false, textField: $userStateViewModel.email)
                UnderlineTextField(textFieldTitle: "Password", isSecured: true, textField: $userStateViewModel.password)
                HStack {
                    Spacer()
                    Button {
                        //TODO: Navigate to forgot password view
                    } label: {
                        Text("Forgot password?")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }.padding([.leading, .trailing], 30)
                
                Spacer()
                Button {
                    if !userStateViewModel.areIncorrectData {
                        userStateViewModel.signIn()
                    }
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
                    .foregroundColor(.primary)
                    .opacity(0.7)
                NavigationLink {
                    RegisterView()
                } label: {
                    Text("Create account")
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                }
            }
            .font(.system(size: 16))
            .padding(.bottom, 30)
        }
        .alert(isPresented: $userStateViewModel.areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text(userStateViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
        .background(Color("Background"))
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .previewDevice("iPhone 12")
    }
}
