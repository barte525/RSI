//
//  ContentView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 30/03/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("neverLogged") var neverLogged = true
    
    init() {
//            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        KeychainManager.logout()
    }
    
    var body: some View {
        NavigationView {
            if neverLogged {
                RegisterView()
            } else {
                LogInView()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
