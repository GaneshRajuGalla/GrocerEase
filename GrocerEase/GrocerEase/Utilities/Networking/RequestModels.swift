//
//  RequestModels.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation

// MARK: - CheckoutRequest

struct CheckoutRequest: Encodable{
    let amount:Double
    let currency:String
}
