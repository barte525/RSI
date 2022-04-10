//
//  AssetsTabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct AssetsTabView: View {
    
    @State var searchText: String = ""
    @State var userAssets: [UserAsset] = UserAsset.mock
    
    var body: some View {
        VStack {
//            TextField("Search", text: $searchText)
//                .background(Color("SecondaryBackground"))
//                .cornerRadius(10)
            if userAssets.count > 0 {
                List(UserAsset.mock) { asset in
                    HStack {
                        Text(asset.assetName)
                        Spacer()
                        Text("\(asset.assetAmount)")
                    }
                    .padding([.leading, .trailing], 10)
                }
            } else {
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .scaledToFit()
                    Text("No asssets. Please add new one at first")
                        .foregroundColor(Color("DarkPurple"))
                        .fontWeight(.semibold)
                        .padding(.top, 0)
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
        .background(Color("Background"))
    }
}

struct AssetsTabView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsTabView()
    }
}
