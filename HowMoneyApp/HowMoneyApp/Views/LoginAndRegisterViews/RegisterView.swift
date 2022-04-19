//
//  RegisterView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 05/04/2022.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerViewModel: RegisterViewModel = .sharedInstance
    
    @State private var isShowingRegisterDetails: Bool = false
    @State private var isRegistered: Bool = false
    @State private var isNotValidEmail: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: Tab(), isActive: $isRegistered) {
                EmptyView()
            }.hidden()
            
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
                UnderlineTextField(textFieldTitle: "Email", isSecured: false, textField: $registerViewModel.email)
                UnderlineTextField(textFieldTitle: "Password", isSecured: true, textField: $registerViewModel.password)
                UnderlineTextField(textFieldTitle: "Repeated password", isSecured: true, textField: $registerViewModel.repeatedPassword)
                Spacer()
                Button {
                    //TODO: register()
                    //2. Incorrect passwords or email - Show alert
                    isNotValidEmail = !registerViewModel.email.isValidEmail
                    registerViewModel.checkPasswords()
                    //1. Passwords are the same - go to next register view
                    if !isNotValidEmail || !registerViewModel.arePasswordsCorrect {
                        isShowingRegisterDetails.toggle()
                    }
                } label: {
                    ButtonText(text: "Register")
                }
                .sheet(isPresented: $isShowingRegisterDetails) {
                    NavigationView {
                        VStack {
                            RegisterDetailsView(isShowingRegisterDetails: $isShowingRegisterDetails)
                        }
                        .navigationTitle("Create account")
                        .navigationBarItems(leading: Button("Cancel") {
                            isShowingRegisterDetails.toggle()
                        })
                    }
                }
                Spacer()
            }
            .background(Color("Lavenda"))
            .cornerRadius(30)
            .padding([.trailing, .leading], 40)
            .padding(.bottom, 2)
            HStack {
                Text("Already have an account? ")
                    .foregroundColor(.primary)
                    .opacity(0.7)
                NavigationLink {
                    //TODO: Navigate to LogIn Account View
                    LogInView()
                    
                } label: {
                    Text("Sign In")
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                }
            }
            .font(.system(size: 16))
            .padding(.bottom, 30)
        }
        .alert(isPresented: $isNotValidEmail) {
            Alert(title: Text("Invalid email"),
                  message: Text("Please enter valid email"), dismissButton: .cancel(Text("OK")))
        }
        .background(Color("Background"))
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
