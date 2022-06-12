//
//  AssetsTabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct AssetsTabView: View {
    
    @EnvironmentObject var userAssetViewModel: UserAssetViewModel
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
                    ForEach(userAssetViewModel.userAssets.filter{ searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())}, id: \.self) { userAsset in
                        HStack {
                            HStack {
                                Text(userAsset.name)
                                Spacer()
                                Text(AmountFormatter.getRoundedAmount(for: userAsset.amount))
                            }
                            .padding([.leading, .trailing], 10)
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color.accentColor)
                                .onTapGesture {
                                    print("Updating...")
                                }
                        }
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
                userAssetViewModel.deleteAsset(for: userMail)
            } )
        }
    }
    
    func deleteAsset(indexSet: IndexSet) {
        isShowingAlert.toggle()
        let assetsToDelete = indexSet.map { userAssetViewModel.userAssets[$0] }
        guard assetsToDelete.count == 1 else {
            return
        }
        userAssetViewModel.chosenAsset = assetsToDelete[0]
    }
}

struct AssetsTabView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsTabView(userMail: "michael.smith@gmail.com")
    }
}
