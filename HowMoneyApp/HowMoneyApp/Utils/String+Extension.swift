//
//  String+Extension.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/04/2022.
//

import Foundation

extension String {
    var isNumber: Bool {
        return Double(self) != nil
    }
}
