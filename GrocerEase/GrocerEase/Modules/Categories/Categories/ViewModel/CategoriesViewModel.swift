//
//  CategoriesViewModel.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI
import SwiftData

@Observable 
class CategoriesViewModel{
    
    // MARK: - Properties
    
    var groceryCategories:[Categories]?
    var searchCategories:[Categories]?
    var searchText:String = ""
    var placeHolder:String = .search
    var modelContext:ModelContext? = nil
    
    
    
    // fetch from SwiftData
    func fetchCategoriesFromSwiftData(){
        let fetchRequest = FetchDescriptor<Categories>(predicate: #Predicate{$0.categoryName != ""},sortBy: [SortDescriptor(\.categoryName)])
        groceryCategories = try? modelContext?.fetch(fetchRequest)
        searchCategories = groceryCategories
    }
    
    // while searching update data
    func updateGroceryCategories(searchText: String) {
        if !searchText.isEmpty{
            let filtedCategories = groceryCategories?.compactMap { item in
                let titleQuery = item.categoryName?.range(of: searchText,options: .caseInsensitive) != nil
                return titleQuery ? item : nil
            }
            groceryCategories = filtedCategories
            
        } else {
            groceryCategories = searchCategories
        }
    }
    
    
    // MARK: - API Methods
    //--------------------------------------------------------------------------------------
    
    
    // Groceries Request
    
    @MainActor
    func getGroceryCategories() async{
        do{
            do {
                try modelContext?.delete(model: Categories.self)
            } catch {
                print("Failed to delete all Categories.")
            }
            let categories:[Categories] = try await APIClient.sendRequest(endpoint: .groceryCategories)
            
            // save to swiftData
            categories.forEach{modelContext?.insert($0)}
            try? modelContext?.save()
            fetchCategoriesFromSwiftData()
        }catch let error{
            print("Error", error.localizedDescription)
        }
    }
}
