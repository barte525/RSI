//
//  ForgotPasswordView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 17/06/2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    @Binding var isShowingForgotPasswordScreen: Bool
    
    var body: some View {
        VStack {
            List {
                TextField("Email", text: $userStateViewModel.email)
            }
            .frame(maxHeight: 70)
            .padding(.top, 5)
                
            Button {
                userStateViewModel.resetPassword()
                if (!userStateViewModel.areIncorrectData) {
                    isShowingForgotPasswordScreen.toggle()
                }
            } label: {
                Text("Reset")
                    .frame(minWidth: 150, maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color("DarkPurple"))
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 10)
            }
            Spacer()
        }
        .navigationTitle("Reset password")
        .alert(isPresented: $userStateViewModel.areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text(userStateViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(isShowingForgotPasswordScreen: .constant(true))
    }
}
