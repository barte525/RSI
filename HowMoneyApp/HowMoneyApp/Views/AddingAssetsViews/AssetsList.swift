//
//  AssetsList.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 12/04/2022.
//

import SwiftUI

struct AssetsList: View {
    @Binding var isShowingAssetChoice: Bool
    @Binding var chosenAsset: String
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                }
                .navigationTitle("Assets")
                .navigationBarItems(leading:
                    Button("Cancel") {
                        isShowingAssetChoice.toggle()
                    })
                .searchable(text: $searchText)
            }
        }
    }
}

struct AssetsList_Previews: PreviewProvider {
    static var previews: some View {
        AssetsList(isShowingAssetChoice: .constant(true), chosenAsset: .constant("EUR"))
    }
}
