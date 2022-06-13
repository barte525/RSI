//
//  NewAlertView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 13/06/2022.
//

import SwiftUI

struct NewAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var chosenAsset: Asset? = nil
    @State var targetValueTextField: String = ""
    @State var emailTextField: String = ""
    @State var isShowingAssetChoice: Bool = false
    @State var areIncorrectData: Bool = false
    @Binding var isAlertSet: Bool
    
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
                        Text(chosenAsset?.name ?? "")
                            .foregroundColor(Color.secondary)
                        Image(systemName: "chevron.right")
                    }
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(Color.primary)
                }
                
                TextField("Target value", text: $targetValueTextField)
                    .onChange(of: targetValueTextField, perform: { amount in
                        targetValueTextField = AmountFormatter.formatByType(value: amount, of: chosenAsset?.type)
                })
                .disabled(chosenAsset == nil)
                .keyboardType(.decimalPad)
                .padding([.leading, .trailing], 10)
                
                TextField("Email", text: $emailTextField)
                    .padding([.leading, .trailing], 10)
            }
            .frame(maxHeight: 200)
            .padding(.top, 5)
            
            Button {
                //TODO: Move validation to ViewModel
                if (!emailTextField.isValidEmail) {
                    areIncorrectData = true
                }
                if (!targetValueTextField.isNumber) {
                    areIncorrectData = true
                }
                
                if !areIncorrectData {
                    isAlertSet.toggle()
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
            AssetsList(isShowingAssetChoice: $isShowingAssetChoice, chosenAsset: $chosenAsset)
        }
        .alert(isPresented: $areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text("Check if you chose asset, enter valid target value and email."), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct NewAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlertView(isAlertSet: .constant(false))
    }
}
