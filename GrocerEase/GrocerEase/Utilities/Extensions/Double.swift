//
//  Double.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation

extension Double {
    
    func toString(decimalPlaces: Int = 2) -> String {
        let formatString = String(format: "%%.%df", decimalPlaces)
        return String(format: formatString, self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
}

