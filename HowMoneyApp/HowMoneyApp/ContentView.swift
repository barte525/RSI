//
//  ContentView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 30/03/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userStateViewModel = UserStateViewModel(userManager: UserManager(), fetcher: UserAssetFetcher())
    
    init() {
        KeychainManager.logout()
    }
    
    var body: some View {
        NavigationView{
            ApplicationSwitcher()
        }
        .environmentObject(userStateViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
