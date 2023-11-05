//
//  UIFont.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation
import SwiftUI

enum FontFamily: String {
    case roboto = "Roboto"
}

enum FontSize: CGFloat {
    case size10 = 10
    case size14 = 14
    case size15 = 15
    case size17 = 17
    case size18 = 18
    case size20 = 20
    case size22 = 22
    case size25 = 25
    case size27 = 27
    case size29 = 29
    case size30 = 30
    case size34 = 34
}


extension Font {
    static func customFont(family: FontFamily, size: FontSize) -> Font {
        if let customFont = UIFont(name: family.rawValue, size: size.rawValue) {
            return Font(customFont)
        } else {
            return Font.system(size: size.rawValue)
        }
    }
}
