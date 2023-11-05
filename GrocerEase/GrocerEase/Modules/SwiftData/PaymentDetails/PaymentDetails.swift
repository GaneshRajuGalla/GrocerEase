//
//  PaymentDetails.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation
import SwiftData

@Model
final public class PaymentDetails{
    
    //@Attribute(.unique) var id: UUID = UUID()
    var nameOfTheCard:String
    var adress:String
    var cardNum:String
    var expiryDate:String
    var cvc:String
    var deliveryOption:String
    var nonContactDelivery:Bool
    
    init(nameOfTheCard: String, adress:String, cardNum: String, expiryDate: String, cvc: String, deliveryOption: String,nonContactDelivery:Bool) {
        self.nameOfTheCard = nameOfTheCard
        self.adress = adress
        self.cardNum = cardNum
        self.expiryDate = expiryDate
        self.cvc = cvc
        self.deliveryOption = deliveryOption
        self.nonContactDelivery = nonContactDelivery
    }
}
