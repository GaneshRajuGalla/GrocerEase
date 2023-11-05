//
//  TabItems.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation
import SwiftUI

// MARK: - TabItems

enum TabItems: Hashable, CaseIterable{
    case categories
    case cart
    case profile
    
    // TODO: - Image
    
    var image:ImageResource{
        switch self {
        case .categories:
            return .category
        case .cart:
            return .shopping
        case .profile:
            return .user
        }
    }
}
