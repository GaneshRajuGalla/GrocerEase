//
//  GroceryDetailViewModel.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation
import SwiftUI

@Observable class GroceryDetailViewModel{
    
    // MARK: - Properties
    
    var subCategoriesModel:SubCategoriesModel?
    
    // MARK: - Init
    
    init(subCategoriesModel: SubCategoriesModel) {
        self.subCategoriesModel = subCategoriesModel
    }
}
