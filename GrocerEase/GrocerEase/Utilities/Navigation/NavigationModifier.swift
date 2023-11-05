//
//  NavigationModifier.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation
import SwiftUI

struct NavigationModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var route: [Routes]
    
    @ViewBuilder
    fileprivate func coordinator(route: Routes) -> some View{
        switch route {
        case .subCategoriesView(let category):
            SubCategoriesView(category: category)
        case .groceryDetail(let subCategoriesModel):
            GroceryDetailView(subCategoriesModel: subCategoriesModel)
        case .confirmation:
            ConfirmationView()
        case .billing(let paymentDetails):
            BillingView(paymentDetails: paymentDetails)
        case .paymentSucess:
            PaymentSucessView()
        }
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        NavigationStack(path: $route) {
            content
                .navigationDestination(for: Routes.self) { route in
                    coordinator(route: route)
                }
        }
    }
}


extension View{
    func navigation(path: Binding<[Routes]>) -> some View{
        self.modifier(NavigationModifier(route: path))
    }
}
