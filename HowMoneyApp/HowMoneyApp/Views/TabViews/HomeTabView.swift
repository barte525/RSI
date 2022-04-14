//
//  HomeTabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct HomeTabView: View {
    
    @State var currencyPreferenceChoice: String = K.preferenceCurrencies[0]
    @State var totalBudget: Double = 0.0
    
    var body: some View {
        VStack {
            VStack {
                Text("Total Budget")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20))
                    .padding(.bottom, 15)
                Text("\(currencyPreferenceChoice) \(totalBudget)")
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
        HomeTabView()
    }
}
