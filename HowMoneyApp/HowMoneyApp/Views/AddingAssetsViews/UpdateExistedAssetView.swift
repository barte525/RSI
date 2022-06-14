//
//  UpdateExistedAssetView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 12/06/2022.
//

import SwiftUI

struct UpdateExistedAssetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userAssetViewModel: UserAssetViewModel
    @State var amountTextField: String = ""
    var chosenAsset: UserAsset?
    var userMail: String
    var userId: String?
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Asset")
                    Spacer()
                    Text(chosenAsset?.name ?? "")
                }
                .foregroundColor(Color.secondary)
                .padding(.trailing, 5)
                
                TextField("Amount", text: $amountTextField)
                    .keyboardType(.decimalPad)
            }
            .frame(maxHeight: 130)
            
            Button {
                userAssetViewModel.putAsset(userId: userId, userMail: userMail, assetId: chosenAsset?.assetId, oldAmount: chosenAsset?.amount, additionalAmount: amountTextField)
                if !userAssetViewModel.areIncorrectData {
                    presentationMode.wrappedValue.dismiss()
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
        .padding(.top, 20)
        .padding([.leading, .trailing], 10)
        .navigationTitle(Text("Add existed asset"))
        .alert(isPresented: $userAssetViewModel.areIncorrectData) {
            Alert(title: Text("Error occurs"),
                  message: Text(userAssetViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct UpdateExistedAssetView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateExistedAssetView(userMail: "jan.smith@gmail.com")
    }
}
