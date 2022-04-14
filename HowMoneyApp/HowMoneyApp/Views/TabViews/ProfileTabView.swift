//
//  ProfileTabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct ProfileTabView: View {
    
    @State var nameTextField: String = ""
    @State var surnameTextField: String = ""
    @State var emailTextField: String = ""
    @State var currencyPreferenceSelection: String = "EUR"
    @State var isShowingPasswordChangingAlert: Bool = false
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("General")) {
                    Text("Name")
                    Text("Surname")
                    Text("Email")
                }
                
                Section(header: Text("Preferences")) {
                    Picker("Currency", selection: $currencyPreferenceSelection) {
                        ForEach(K.preferenceCurrencies, id: \.self) { asset in
                            Text(asset)
                        }
                    }
                }
                
                Section(header: Text("Password")) {
                    Button {
                        isShowingPasswordChangingAlert.toggle()
                    } label: {
                        HStack {
                            Text("Change password...")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color.secondary)
                        }
                        .padding([.leading, .trailing], 10)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingPasswordChangingAlert) {
            PasswordChangeView(isShown: $isShowingPasswordChangingAlert)
        }
        .background(Color("Background"))
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView()
    }
}
