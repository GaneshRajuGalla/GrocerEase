//
//  ConfirmationViewModel.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation
import SwiftUI
import StripePaymentSheet

@Observable class ConfirmationViewModel{
    
    // MARK: - Properties
    
    var startPaymentResponse:StartPaymentResponse?
    var paymentSheet: PaymentSheet?
    var paymentResult: PaymentSheetResult?
    var deliveryOptions:[DeliveryOption] = DeliveryOption.getData()
   
    
    // MARK: - Methods
    
    // TODO: - Start Payment Request
    
    @MainActor
    func sendStartpaymentRequest() async{
        do{
            if let amount = UserDefaults.standard.value(forKey: "amount") as? Double, amount != 0.0 {
                let request = CheckoutRequest(amount: amount < 2 ? 2 : amount, currency: "usd")
                startPaymentResponse = try await APIClient.sendRequest(endpoint: .checkOut(request))
                
                // Stripe
                if let response = startPaymentResponse{
                    STPAPIClient.shared.publishableKey = response.publishableKey
                    var configuration = PaymentSheet.Configuration()
                    configuration.merchantDisplayName = .grocerEase
                    configuration.customer = .init(id: response.customer ?? "", ephemeralKeySecret: response.ephemeralKey ?? "")
                    configuration.allowsDelayedPaymentMethods = true
                    self.paymentSheet = PaymentSheet(paymentIntentClientSecret:response.paymentIntent ?? "", configuration: configuration)
                }
            }
        }catch{
            print("Error: \(error.localizedDescription)")
        }
    }
}


// TODO: - Static Data
struct DeliveryOption: Hashable{
    let image:ImageResource
    let option:String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
    
    static func getData() -> [DeliveryOption]{
        return [
            DeliveryOption(image: .walking, option: .pickitupMyself),
            DeliveryOption(image: .bike, option: .byCourier),
            DeliveryOption(image: .drone, option: .byDrone)
        ]
    }
}

