//
//  String.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation

extension String{
    static let categories = "Categories"
    static let search = "Search"
    static let addToCart = "ADD TO CART"
    static let useThisCard = "USE THIS CARD"
    static let orderMore = "ORDER MORE"
    static let orderNow  = "ORDER NOW "
    static let close = "CLOSE"
    static let nonContactDeliveries = "Non-Contact Deliveries"
    static let nonContactDesp = "When placing an order, select the option “Contactless delivery” and the courier will leave your order at the door."
    static let dismiss = "Dismiss"
    static let thankyou = "Thank You For shopping with us"
    static let change = "CHANGE"
    static let paymentMethod = "Payment Method"
    static let deliveryAddress = "Delivery Address"
    static let deliveryOptions = "Delivery Options"
    static let nonContactDelivery = "Non-Contact Delivery"
    static let pickitupMyself = "I’ll pick it up Myself"
    static let byCourier = "By Courier"
    static let byDrone = "By Drone"
    static let confirmation = "Confirmation"
    static let creditCard = "Credit / Debit card"
    static let nameOfTheCard = "Name on Card"
    static let cardNumber = "Card Number"
    static let expiryDate = "Expiry Date"
    static let cvc = "CVC"
    static let address:String = """
        Alexandra Smith
        Cesu 31 k-2 5.st, SIA Chili
        Riga
        LV–1012
        Latvia
        """
    static let makePayment = "Make Payment"
    static let loading = "Payment Loading"
    static let grocerEase = "GrocerEase"
    static let paymentCancelled = "PaymentCancelled"
    static let paymentFailed = "Payment Failed"
}

extension String {
    func maskCreditCard() -> String {
        let digits = self.suffix(16)
        var maskedDigits = ""
        
        for (index, digit) in digits.enumerated() {
            if index > 0 && index % 4 == 0 {
                maskedDigits.append(" ")
            }
            maskedDigits.append(index >= digits.count - 4 ? String(digit) : "*")
        }
        
        return maskedDigits
    }
}


extension String {
    
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw APIError.invalidURL
        }
        return url
    }
    
    func formatCardNumber() -> String {
        let stripped = self.replacingOccurrences(of: " ", with: "") 
        var formatted = ""
        
        for (index, character) in stripped.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted.append(" ")
            }
            formatted.append(character)
        }
        
        return formatted
    }
}
