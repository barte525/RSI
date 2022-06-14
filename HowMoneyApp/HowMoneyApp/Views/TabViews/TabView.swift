//
//  TabView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 09/04/2022.
//

import SwiftUI

struct Tab: View {
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    @StateObject var userAssetViewModel: UserAssetViewModel = .init(fetcher: UserAssetFetcher())
    @State private var selection: String = "Home"
    @State var isEditingProfile: Bool = false
    
    var body: some View {
        TabView(selection: $selection) {
            HomeTabView(currencyPreferenceChoice: userStateViewModel.currencyPreference, totalBudget: userStateViewModel.sum)
                .onAppear {
                    userStateViewModel.fetchSum()
                }
                .tag(TabBarSelection.home.rawValue)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            AssetsTabView(userMail: userStateViewModel.email)
                .tag(TabBarSelection.assets.rawValue)
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Assets")
                }
                .environmentObject(userAssetViewModel)
                .environmentObject(userStateViewModel)
            
            ProfileTabView()
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
                AlertsListView()
            case TabBarSelection.assets.rawValue:
                NewAssetView(userMail: userStateViewModel.email, userId: userStateViewModel.loggedUser?.id)
                    .environmentObject(userAssetViewModel)
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
        Tab()
    }
}
