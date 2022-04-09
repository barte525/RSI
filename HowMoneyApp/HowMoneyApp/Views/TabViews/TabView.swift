//
//  TabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct Tab: View {
    @State private var selection: String = "Home"
    
    var body: some View {
        TabView(selection: $selection) {
            HomeTabView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            AssetsTabView()
                .tag("Your assets")
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Assets")
                }
            
            ProfileTabView()
                .tag("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
        }
        .navigationTitle(selection)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(trailing:
                                NavigationLink {

        } label: {
            Image(systemName: K.tabBarsTrailingItemsName[selection]!)
        }
        )
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
