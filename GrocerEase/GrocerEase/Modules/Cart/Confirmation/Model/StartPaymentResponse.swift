//
//  StartPaymentResponse.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation

// MARK: - SubCategorie

struct StartPaymentResponse: Codable {
    let paymentIntent, ephemeralKey, customer, publishableKey: String?
}
