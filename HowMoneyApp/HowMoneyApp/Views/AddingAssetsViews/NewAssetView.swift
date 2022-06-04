//
//  NewAssetView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 12/04/2022.
//

import SwiftUI

struct NewAssetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userAssetViewModel: UserAssetViewModel
    @State var chosenAsset: Asset? = nil
    @State var amountTextField: String = ""
    @State var isShowingAssetChoice: Bool = false
    var userMail: String
    var userId: String?
    
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
                
                TextField("Amount", text: $amountTextField)
                    .onChange(of: amountTextField, perform: { amount in
                        amountTextField = AmountFormatter.formatByType(value: amount, of: chosenAsset?.type)
                })
                .disabled(chosenAsset == nil)
                .keyboardType(.decimalPad)
                .padding([.leading, .trailing], 10)
            }
            .frame(maxHeight: 150)
            .padding(.top, 5)
            
            Button {
                userAssetViewModel.addAsset(userId: userId, userMail: userMail, for: chosenAsset, amount: amountTextField)
                if !userAssetViewModel.areIncorrectData {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Add")
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
        .navigationTitle("New Asset")
        .sheet(isPresented: $isShowingAssetChoice, onDismiss: {  }) {
            AssetsList(isShowingAssetChoice: $isShowingAssetChoice, chosenAsset: $chosenAsset)
        }
        .alert(isPresented: $userAssetViewModel.areIncorrectData) {
            Alert(title: Text("Invalid data"),
                  message: Text(userAssetViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct NewAssetView_Previews: PreviewProvider {
    static var previews: some View {
        NewAssetView(userMail: "")
    }
}
