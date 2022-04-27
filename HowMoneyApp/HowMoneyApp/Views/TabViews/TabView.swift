//
//  TabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct Tab: View {
    @State private var selection: String = "Home"
    @State var isEditingProfile: Bool = false
    
    var user: User
    
    var body: some View {
        TabView(selection: $selection) {
            HomeTabView(currencyPreferenceChoice: user.currencyPreference, totalBudget: user.sum)
                .tag(TabBarSelection.home.rawValue)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            AssetsTabView(userMail: user.email)
                .tag(TabBarSelection.assets.rawValue)
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Assets")
                }
            
            ProfileTabView(user: user)
                .tag(TabBarSelection.profile.rawValue)
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
            switch selection {
            case TabBarSelection.home.rawValue:
                EmptyView()
            case TabBarSelection.assets.rawValue:
                NewAssetView()
            case TabBarSelection.profile.rawValue:
                EditProfileView()
            default:
                EmptyView()
            }
        } label: {
            Image(systemName: K.tabBarsTrailingItemsName[selection]!)
        }
        )
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        Tab(user: User(id: "1234567", email: "john.smith@gmail.com", name: "John", surname: "Smith", sum: 0, currencyPreference: "EUR"))
    }
}
