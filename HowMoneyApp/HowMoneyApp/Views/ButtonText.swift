//
//  ButtonText.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 05/04/2022.
//

import SwiftUI

struct ButtonText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .frame(minWidth: 150, maxWidth: .infinity, minHeight: 55)
            .foregroundColor(Color("DarkPurple"))
            .font(.system(size: 18, weight: .semibold))
            .background(Color("Background"))
            .cornerRadius(30)
            .padding([.leading, .trailing], 30)
    }
}

struct ButtonText_Previews: PreviewProvider {
    static var previews: some View {
        ButtonText(text: "Sign In")
    }
}
