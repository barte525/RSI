//
//  UnderlineTextField.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 05/04/2022.
//

import SwiftUI

struct UnderlineTextField: View {
    var textFieldTitle: String
    var isSecured: Bool
    @Binding var textField: String
    
    var body: some View {
        VStack {
            ZStack {
                if isSecured {
                    SecureField(textFieldTitle, text: $textField)
                } else {
                    TextField(textFieldTitle, text: $textField)
                }
            }
            .foregroundColor(.white)
            .padding([.trailing, .leading], 30)
            .padding(.top, 20)
            
            Divider()
             .frame(height: 1)
             .background(Color.white)
             .padding(.horizontal, 30)
        }
    }
}

struct UnderlineTextField_Previews: PreviewProvider {
    static var previews: some View {
        UnderlineTextField(textFieldTitle: "Email", isSecured: false, textField: .constant(""))
    }
}
