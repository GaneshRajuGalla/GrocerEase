//
//  GrocerEaseApp.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import SwiftUI
import SwiftData
import StripeCore

@main
struct GrocerEaseApp: App {

    // MARK: - Properties
    
    @ObservedObject var manager:NavigationManager = .init()
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Categories.self,PaymentDetails.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }

    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            LaunchScreen()
                .preferredColorScheme(.light)
                .onOpenURL { incomingURL in
                    let stripeHandled = StripeAPI.handleURLCallback(with: incomingURL)
                    manager.cartRoutes.append(.confirmation)
                    if (!stripeHandled) {
                        // This was not a Stripe url – handle the URL normally as you would
                    }
                }
        }
        .environmentObject(manager)
        .modelContainer(modelContainer)
    }
}
