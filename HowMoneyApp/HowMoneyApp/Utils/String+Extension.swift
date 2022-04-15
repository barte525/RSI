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
    
    var isValidEmail: Bool {
        let emailPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"self MATCHES %@", emailPattern)
        return predicate.evaluate(with: self)
    }
}
