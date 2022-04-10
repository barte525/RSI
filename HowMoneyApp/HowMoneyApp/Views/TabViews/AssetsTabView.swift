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
            VStack {
                TextField("Search", text: $searchText)
                    .padding(7)
                    .background(Color("ControlBackground"))
                    .cornerRadius(10)
                    .frame(height: 55)
            }.padding([.leading, .trailing], 15)
            
            if userAssets.count > 0 {
                List {
                    ForEach(UserAsset.mock.filter{ searchText.isEmpty || $0.assetName.lowercased().contains(searchText.lowercased())}) { asset in
                        HStack {
                            Text(asset.assetName)
                            Spacer()
                            Text("\(asset.assetAmount)")
                        }
                        .padding([.leading, .trailing], 10)
                    }.onDelete(perform: deleteAsset) //TODO: Delete item
                }
                .padding(.top, -15)
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
    
    func deleteAsset(indexSet: IndexSet) {
        //TODO: Delete asset using view model
    }
}

struct AssetsTabView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsTabView()
    }
}
