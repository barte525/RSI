//
//  AssetsTabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct AssetsTabView: View {
    
    @StateObject var userAssetViewModel: UserAssetViewModel = .init(fetcher: UserAssetFetcher())
    @State var searchText: String = ""
    @State var isShowingAlert: Bool = false
    var userMail: String
    var assetToDelete: IndexSet? = nil
    
    var body: some View {
        VStack {
            VStack {
                TextField("Search", text: $searchText)
                    .padding(10)
                    .background(Color("ControlBackground"))
                    .cornerRadius(10)
                    .frame(height: 60)
            }.padding([.leading, .trailing], 15)
            
            if userAssetViewModel.userAssets.count > 0 {
                List {
                    ForEach(userAssetViewModel.userAssets.filter{ searchText.isEmpty || $0.asset.name.lowercased().contains(searchText.lowercased())}) { userAsset in
                        HStack {
                            Text(userAsset.asset.name)
                            Spacer()
                            Text("\(AmountFormatter.getRoundedAmountToDecimalPlaces(for: userAsset.assetAmount, assetType: AssetType(rawValue: userAsset.asset.type) ?? .currency))")
                        }
                        .padding([.leading, .trailing], 10)
                    }.onDelete(perform: deleteAsset)
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
        .onAppear {
            userAssetViewModel.getAssets(for: userMail)
        }
        .background(Color("Background"))
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Delete asset"),
                  message: Text("Are you sure you want to permanently delete chosen asset?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("OK")) {
                //TODO: - Delete asset using view model
                print("Deleting...")
            } )
        }
    }
    
    func deleteAsset(indexSet: IndexSet) {
        isShowingAlert.toggle()
        //TODO: Pass to view model index set to delete asset
    }
}

struct AssetsTabView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsTabView(userMail: "michael.smith@gmail.com")
    }
}
