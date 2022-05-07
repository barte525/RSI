//
//  RegisterDetailsView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 06/04/2022.
//

import SwiftUI

struct RegisterDetailsView: View {
    
    @StateObject var registerViewModel: UserStateViewModel = .sharedInstance
    @Binding var isShowingRegisterDetails: Bool
    
    var body: some View {
        ZStack {
            VStack {
                UnderlineTextField(textFieldTitle: "Email", isSecured: false, textField: $registerViewModel.email)
                    .padding(.top, 20)
                UnderlineTextField(textFieldTitle: "Password", isSecured: true, textField: $registerViewModel.password)
                UnderlineTextField(textFieldTitle: "Repeated password", isSecured: true, textField: $registerViewModel.repeatedPassword)
                UnderlineTextField(textFieldTitle: "Name", isSecured: false, textField: $registerViewModel.name)
                UnderlineTextField(textFieldTitle: "Surname", isSecured: false, textField: $registerViewModel.surname)
                VStack {
                    Text("Total sum currency preference")
                        .foregroundColor(Color.white)
                    Picker("", selection: $registerViewModel.currencyPreference) {
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
                    registerViewModel.register()
                    //TODO: register()
                    //1. Fields are correct - navigate to home view
                    isShowingRegisterDetails.toggle()
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
        RegisterDetailsView(isShowingRegisterDetails: .constant(true))
    }
}
