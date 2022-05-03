//
//  HomeTabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct HomeTabView: View {
    
    var currencyPreferenceChoice: String
    var totalBudget: Double
    
    var body: some View {
        VStack {
            VStack {
                Text("Total Budget")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20))
                    .padding(.bottom, 15)
                Text("\(currencyPreferenceChoice) \(AmountFormatter.getRoundedAmountToDecimalPlaces(for: totalBudget, assetType: AssetType.currency))")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(Color("Lavenda"))
            .cornerRadius(10)
            .padding([.leading, .trailing], 30)
            .padding(.top, 20)
            
            Spacer()
        }
        .background(Color("Background"))
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(currencyPreferenceChoice: "EUR", totalBudget: 0.0)
    }
}
