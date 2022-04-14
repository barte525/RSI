//
//  NewAssetView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 12/04/2022.
//

import SwiftUI

struct NewAssetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var chosenAsset: String = ""
    @State var amountTextField: String = ""
    @State var isShowingAssetChoice: Bool = false
    
    var body: some View {
        VStack {
            List {
                Button {
                    isShowingAssetChoice.toggle()
                } label: {
                    HStack {
                        Text("Asset")
                            .foregroundColor(Color.primary)
                        Spacer()
                        Text(chosenAsset)
                            .foregroundColor(Color.secondary)
                        Image(systemName: "chevron.right")
                    }
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(Color.primary)
                }
                
                TextField(text: $amountTextField, prompt: Text("Amount")) {
                    
                }
                .padding([.leading, .trailing], 10)
            }
            .frame(maxHeight: 150)
            .padding(.top, 5)
            
            Button {
                //TODO: Add new asset
                self.presentationMode.wrappedValue.dismiss()
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
            Spacer()
        }
        .background(Color("Background"))
        .navigationTitle("New Asset")
        .sheet(isPresented: $isShowingAssetChoice, onDismiss: {  }) {
            AssetsList(isShowingAssetChoice: $isShowingAssetChoice, chosenAsset: $chosenAsset)
        }
    }
}

struct NewAssetView_Previews: PreviewProvider {
    static var previews: some View {
        NewAssetView()
    }
}
