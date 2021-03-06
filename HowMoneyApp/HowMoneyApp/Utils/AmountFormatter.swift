//
//  AmountFormatter.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/04/2022.
//

import Foundation

struct AmountFormatter {
    
    private static func getValidNumber(for value: String) -> String {
        if value.isNumber {
            return value
        }
        var filteredValue = value.filter { "0123456789.".contains($0) }
        let last_occurrence = filteredValue.lastIndex(of: ".")
        if filteredValue.firstIndex(of: ".") == last_occurrence {
            return filteredValue
        } else {
            filteredValue.remove(at: last_occurrence!)
            return filteredValue
        }
    }
    
    private static func getMaximumFractionDigits(for number: String, fractionDigitsNumber: Int) -> String {
        let splittedNumber = number.split(separator: ".")
        if splittedNumber.count == 2 {
            var reducedNumber = ""
            reducedNumber += splittedNumber[0]
            reducedNumber += "."
            reducedNumber += splittedNumber[1].prefix(fractionDigitsNumber)
            return reducedNumber
        }
        return number
    }
    
    private static func formatCurrency(for value: String) -> String {
        let validNumber =  getValidNumber(for: value)
        return getMaximumFractionDigits(for: validNumber, fractionDigitsNumber: 2)
    }
    
    private static func formatMetal(for value: String) -> String {
        let validNumber = getValidNumber(for: value)
        return getMaximumFractionDigits(for: validNumber, fractionDigitsNumber: 8)
    }
    
    private static func formatCrypto(for value: String) -> String {
        let validNumber = getValidNumber(for: value)
        return getMaximumFractionDigits(for: validNumber, fractionDigitsNumber: 8)
    }
    
    static func formatByType(value: String, of assetType: String?) -> String {
        switch assetType {
        case AssetType.currency.rawValue:
            return formatCurrency(for: value)
        case AssetType.metal.rawValue:
            return formatMetal(for: value)
        case AssetType.crypto.rawValue:
            return formatCrypto(for: value)
        default:
            return value
        }
    }
    
    static func getRoundedAmountToDecimalPlaces(for value: Double, assetType: AssetType) -> String {
        var numberPlaces = 0
        switch assetType {
        case .currency:
            numberPlaces = 2
        case .crypto:
            numberPlaces = 8
        case .metal:
            numberPlaces = 8
        }
        return String(format: "%.\(numberPlaces)f", value)
    }
    
    static func getRoundedAmount(for value: Double) -> String {
        let valueString = "\(value)"
        let valuesParts = valueString.components(separatedBy: ".")
        
        var decimalResults = ""
        if valuesParts.count == 2 {
            for decimalChar in valuesParts[1] {
                if decimalResults.count > 2 && decimalResults != "00" {
                    return valuesParts[0] + "." + decimalResults
                }
                decimalResults += "\(decimalChar)"
            }
        } else {
            decimalResults = "00"
        }
        return valuesParts[0] + "." + decimalResults
    }
    
    static func getFormattedAmount(for value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
