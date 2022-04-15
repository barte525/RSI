//
//  RegisterDetailsView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 06/04/2022.
//

import SwiftUI

struct RegisterDetailsView: View {
    @Binding var isShowingRegisterDetails: Bool
    @Binding var emailTextField: String
    @Binding var passwordTextField: String
    @Binding var repeatedPasswordTextField: String
    @State var nameTextField: String = ""
    @State var surnameTextField: String = ""
    @State var chosenCurrencyPreference: String = "EUR"
    
    var body: some View {
        ZStack {
            VStack {
                UnderlineTextField(textFieldTitle: "Email", isSecured: false, textField: $emailTextField)
                    .padding(.top, 20)
                UnderlineTextField(textFieldTitle: "Password", isSecured: true, textField: $passwordTextField)
                UnderlineTextField(textFieldTitle: "Repeated password", isSecured: true, textField: $repeatedPasswordTextField)
                UnderlineTextField(textFieldTitle: "Name", isSecured: true, textField: $nameTextField)
                UnderlineTextField(textFieldTitle: "Surname", isSecured: true, textField: $surnameTextField)
                VStack {
                    Text("Total sum currency preference")
                        .foregroundColor(Color.white)
                    Picker("fasfasf", selection: $chosenCurrencyPreference) {
                        ForEach(K.preferenceCurrencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color("PickerBackground"))
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                }
                .padding(.top, 15)
                Spacer()
                Button {
                    isShowingRegisterDetails.toggle()
                    //TODO: register()
                    //1. Fields are correct - navigate to home view
                    //2. Incorrect fields - Show alert
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
        RegisterDetailsView(isShowingRegisterDetails: .constant(true), emailTextField: .constant("john.smith@gmail.com"), passwordTextField: .constant("p@ssw0rd"), repeatedPasswordTextField: .constant("p@ssw0rd"))
    }
}
