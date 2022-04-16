//
//  Spinner.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 16/04/2022.
//

import SwiftUI

struct Spinner: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .padding(20)
            .background(.regularMaterial)
            .mask(RoundedRectangle(cornerRadius: 10))
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
