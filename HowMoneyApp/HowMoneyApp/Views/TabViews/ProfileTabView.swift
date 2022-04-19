//
//  ProfileTabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct ProfileTabView: View {
    
    var user: User
    @State var currencyPreferenceSelection: String = "EUR"
    @State var isShowingPasswordChangingAlert: Bool = false
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("General")) {
                    Text(user.name)
                    Text(user.surname)
                    Text(user.email)
                }
                .foregroundColor(Color.secondary)
                
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
            
            Button {
                //TODO: Sign out the user
            } label: {
                Text("Sign out")
                    .frame(minWidth: 150, maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color("DarkPurple"))
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 10)
            }
            .padding(.bottom, 30)
        }
        .sheet(isPresented: $isShowingPasswordChangingAlert) {
            PasswordChangeView(isShown: $isShowingPasswordChangingAlert)
        }
        .background(Color("Background"))
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView(user: UserMock.user1)
    }
}
