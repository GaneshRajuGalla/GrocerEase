//
//  Routes.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation

// MARK: - Routes

enum Routes: Hashable, Equatable{
    case subCategoriesView(Categories)
    case groceryDetail(SubCategoriesModel)
    case confirmation
    case billing(PaymentDetails)
    case paymentSucess
}

