//
//  ApplicationSwitcher.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 07/05/2022.
//

import SwiftUI

struct ApplicationSwitcher: View {
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    
    var body: some View {
        if userStateViewModel.isLogged {
            withAnimation {
                Tab()
            }
        } else {
            withAnimation {
                LogInView()
            }
        }
    }
    
}

struct ApplicationSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationSwitcher()
    }
}
