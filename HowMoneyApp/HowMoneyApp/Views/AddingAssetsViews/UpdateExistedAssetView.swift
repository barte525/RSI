//
//  UpdateExistedAssetView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 12/06/2022.
//

import SwiftUI

struct UpdateExistedAssetView: View {
    var chosenAssetName: String
    @State var amountText: String = ""
    
    var body: some View {
        List {
            HStack {
                Text("Asset")
                Spacer()
                Text(chosenAssetName)
            }
            .foregroundColor(Color.secondary)
            
            TextField("Amount", text: $amountText)
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
