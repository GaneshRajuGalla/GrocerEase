//
//  BillingViewModel.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation
import SwiftUI

class BillingViewModel: ObservableObject{
    
    // MARK: - Properties
    
    @Published var nameOfTheCard:String = ""
    @Published var cardNumber:String = ""
    @Published var expiryData:String = ""
    @Published var cvc:String = ""
    @Published var isBtnEnable:Bool = false
    
    
    // MARK: - Init
    
    init(paymentDetails:PaymentDetails){
        nameOfTheCard = paymentDetails.nameOfTheCard
        cardNumber = paymentDetails.cardNum
        expiryData = paymentDetails.expiryDate
        cvc = paymentDetails.cvc
        cardValidation()
    }
    
    // TODO: - cardValidation
    func cardValidation(){
        if !nameOfTheCard.isEmpty && !cardNumber.isEmpty && !expiryData.isEmpty && !expiryData.isEmpty && !cvc.isEmpty {
            isBtnEnable = true
        }else if cardNumber.count == 16{
            isBtnEnable = true
        }else if cvc.count == 3{
            isBtnEnable = true
        }else{
            isBtnEnable = false
        }
    }
    
    // Limit Text
    func limitText(for type: TextFieldType) {
        switch type {
        case .nameOfTheCard:
            if nameOfTheCard.count > type.characterLimit {
                nameOfTheCard = String(nameOfTheCard.prefix(type.characterLimit))
            }
        case .cardNumber:
            if cardNumber.count > type.characterLimit {
                cardNumber = (String(cardNumber.prefix(type.characterLimit))).formatCardNumber()
            }
        case .expiryData:
            if expiryData.count > type.characterLimit {
                expiryData = String(expiryData.prefix(type.characterLimit))
            }
        case .cvc:
            if cvc.count > type.characterLimit {
                cvc = String(cvc.prefix(type.characterLimit))
            }
        }
    }
}

enum TextFieldType {
    case nameOfTheCard
    case cardNumber
    case expiryData
    case cvc
    
    var characterLimit: Int {
        switch self {
        case .nameOfTheCard:
            return 20
        case .cardNumber:
            return 19
        case .expiryData:
            return 5
        case .cvc:
            return 3
        }
    }
}
