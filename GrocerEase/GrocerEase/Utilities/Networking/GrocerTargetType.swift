//
//  GrocerTargetType.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation

enum GrocerTargetType{
    case groceryCategories
    case grocerySubCategories(String)
    case checkOut(CheckoutRequest)
}

extension GrocerTargetType:TargetType{

    // TODO: - baseURL
    
    var baseURL: String {
        return "http://ec2-13-235-210-59.ap-south-1.compute.amazonaws.com:3000"
    }
    
    // TODO: - method
    
    var method: HTTPMethod {
        switch self {
        case .groceryCategories, .grocerySubCategories:
            return .get
            
        case .checkOut:
            return .post
        }
    }
    
    // TODO: - path
    
    var path: String {
        switch self {
        case .groceryCategories:
            return "router/get/all/categories"
            
        case .grocerySubCategories(let category):
            return "router/get/category/\(category)"
            
        case .checkOut:
            return "start/payment"
        }
    }
    
    // TODO: - parameters
    
    var parameters: RequestParams {
        switch self {
        case .checkOut(let checkoutRequest):
            return .body(checkoutRequest)
            
        default:
            return .query(nil)
        }
    }
}
