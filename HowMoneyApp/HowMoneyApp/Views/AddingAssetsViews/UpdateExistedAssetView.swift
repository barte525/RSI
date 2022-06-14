//
//  UpdateExistedAssetView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 12/06/2022.
//

import SwiftUI

struct UpdateExistedAssetView: View {
    var chosenAssetName: String
    @State var amountTextField: String = ""
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Asset")
                    Spacer()
                    Text(chosenAssetName)
                }
                .foregroundColor(Color.secondary)
                .padding(.trailing, 5)
                
                TextField("Amount", text: $amountTextField)
                    .keyboardType(.decimalPad)
            }
            .frame(maxHeight: 130)
            
            Button {
                print("Adding...")
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
            .disabled(amountTextField.isEmpty || !amountTextField.isNumber)
            
            Spacer()
        }
        .padding(.top, 20)
        .padding([.leading, .trailing], 10)
        .navigationTitle(Text("Add existed asset"))
    }
}

struct UpdateExistedAssetView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateExistedAssetView(chosenAssetName: "BTC")
    }
}
