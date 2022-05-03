//
//  AssetsList.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 12/04/2022.
//

import SwiftUI

struct AssetsList: View {
    
    @StateObject var assetViewModel: AssetsListViewModel = .init(fetcher: AssetFetcher())
    
    @Binding var isShowingAssetChoice: Bool
    @Binding var chosenAsset: Asset?
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(assetViewModel.assetsByType.keys), id: \.self) {
                        assetType in
                        if let assets = assetViewModel.assetsByType[assetType] {
                            Section(header: Text(assetType)) {
                                ForEach(assets.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())}, id: \.self) { asset in
                                    Button {
                                        chosenAsset = asset
                                        isShowingAssetChoice.toggle()
                                    } label: {
                                        Text(asset.name)
                                            .foregroundColor(Color.primary)
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: {
                    assetViewModel.getAllAssets()
                })
                .overlay(loadingView)
                .navigationTitle("Assets")
                .navigationBarItems(leading:
                    Button("Cancel") {
                        isShowingAssetChoice.toggle()
                    })
                .searchable(text: $searchText)
            }
        }
    }
    
    
    @ViewBuilder
    private var loadingView: some View {
        if assetViewModel.isLoading {
            Spinner()
        }
    }
}

struct AssetsList_Previews: PreviewProvider {
    static var previews: some View {
        AssetsList(isShowingAssetChoice: .constant(true), chosenAsset: .constant(Asset(name: "EUR", type: "Currency")))
    }
}
