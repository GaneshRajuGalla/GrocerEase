//
//  NavigationManager.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation
import SwiftUI

class NavigationManager: ObservableObject{
    
    // MARK: - Properties
    
    @Published var selectedTab:TabItems = .categories
    @Published var categoriesRoutes:[Routes] = []
    @Published var cartRoutes:[Routes] = []
    @Published var profileRoutes:[Routes] = []
    
    var tabSelection: Binding<TabItems> {
        Binding{ [weak self] in
            self?.selectedTab ?? .categories
        } set: { [weak self] newValue in
            self?.selectedTab = newValue
        }
    }
    
    // TODO: - Pop to Particular View
    
    func pop(to route: Routes){
        switch selectedTab {
        case .categories:
            categoriesRoutes.removeAll(where: {$0 == route})
        case .cart:
            cartRoutes.removeAll(where: {$0 == route})
        case .profile:
            profileRoutes.removeAll(where: {$0 == route})
        }
    }
    
    // TODO: - Pop to Last View
    
    func popLast(){
        switch selectedTab {
        case .categories:
            categoriesRoutes.removeLast()
        case .cart:
            cartRoutes.removeLast()
        case .profile:
            profileRoutes.removeLast()
        }
    }
    
    // TODO: - Push to Particular View
    
    func push(route:Routes){
        switch selectedTab {
        case .categories:
            categoriesRoutes.append(route)
        case .cart:
            cartRoutes.append(route)
        case .profile:
            profileRoutes.append(route)
        }
    }
    
    // TODO: - Pop to Root View
    
    func popToRoot(){
        switch selectedTab {
        case .categories:
            categoriesRoutes.removeAll()
        case .cart:
            cartRoutes.removeAll()
        case .profile:
            profileRoutes.removeAll()
        }
    }
}
