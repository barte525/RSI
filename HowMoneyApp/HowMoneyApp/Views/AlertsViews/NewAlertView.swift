//
//  NewAlertView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 13/06/2022.
//

import SwiftUI

struct NewAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var alertViewModel: AlertViewModel
    @State var isShowingAssetChoice: Bool = false
    var userMail: String
    
    var body: some View {
        VStack {
            List {
                Button {
                    isShowingAssetChoice.toggle()
                } label: {
                    HStack {
                        Text("Asset")
                            .foregroundColor(Color.primary)
                        Spacer()
                        Text(alertViewModel.chosenAsset?.name ?? "")
                            .foregroundColor(Color.secondary)
                        Image(systemName: "chevron.right")
                    }
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(Color.primary)
                }
                
                TextField("Target value", text: $alertViewModel.targetValueTextField)
                    .onChange(of: alertViewModel.targetValueTextField, perform: { amount in
                        alertViewModel.targetValueTextField = AmountFormatter.formatByType(value: amount, of: alertViewModel.chosenAsset?.type)
                })
                .disabled(alertViewModel.chosenAsset == nil)
                .keyboardType(.decimalPad)
                .padding([.leading, .trailing], 10)
                
                VStack {
                    HStack {
                        Text("Currency for target value:")
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                    
                    Picker("", selection: $alertViewModel.targetValueCurrency) {
                        ForEach(K.preferenceCurrencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color("PickerBackground"))
                    .cornerRadius(10)
                }.padding(.top, 5)
            }
            .frame(maxHeight: 240)
            .padding(.top, 5)
            
            Button {
                alertViewModel.addAlert(userMail: userMail)
                if alertViewModel.isAlertSet {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Set")
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
        .background(Color("Background"))
        .navigationTitle("New Alert")
        .sheet(isPresented: $isShowingAssetChoice, onDismiss: {  }) {
            AssetsList(isShowingAssetChoice: $isShowingAssetChoice, chosenAsset: $alertViewModel.chosenAsset)
        }
        .alert(isPresented: $alertViewModel.areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text(alertViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct NewAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlertView(userMail: "jan.smith@gmail.com")
    }
}
