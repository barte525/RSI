//
//  RegisterDetailsView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 06/04/2022.
//

import SwiftUI

struct RegisterDetailsView: View {
    
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    @Binding var isShowingRegisterDetails: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                UnderlineTextField(textFieldTitle: "Email", isSecured: false, textField: $userStateViewModel.email)
                    .padding(.top, 20)
                UnderlineTextField(textFieldTitle: "Password", isSecured: true, textField: $userStateViewModel.password)
                UnderlineTextField(textFieldTitle: "Repeated password", isSecured: true, textField: $userStateViewModel.repeatedPassword)
                UnderlineTextField(textFieldTitle: "Name", isSecured: false, textField: $userStateViewModel.name)
                UnderlineTextField(textFieldTitle: "Surname", isSecured: false, textField: $userStateViewModel.surname)
                VStack {
                    Text("Total sum currency preference")
                        .foregroundColor(Color.white)
                    Picker("", selection: $userStateViewModel.currencyPreference) {
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
                    userStateViewModel.checkFieldsForRegister()
                    if !userStateViewModel.areIncorrectData {
                        userStateViewModel.register()
                        isShowingRegisterDetails.toggle()
                    }
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
        .alert(isPresented: $userStateViewModel.areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text(userStateViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct RegisterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterDetailsView(isShowingRegisterDetails: .constant(true))
    }
}
