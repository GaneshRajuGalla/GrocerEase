//
//  CustomTabBar.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {
    
    // MARK: - Properties
    
    @Binding var currentTab: TabItems
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItems.allCases, id: \.self) { tab in
                TabBarButton(tab: tab, currentTab: $currentTab)
            }
        }
        .frame(height: 70)
        .background(Color.EEEEEE)
        .clipShape(TopRoundedRectangle(radius: 80))
        .shadow(radius: 1)
    }
}


struct TabBarButton: View {
    
    // MARK: - Properties
    
    let tab: TabItems
    @Binding var currentTab: TabItems
    
    // MARK: - Body
    
    var body: some View {
        ZStack{
            Button(action: {
                currentTab = tab
            }) {
                Image(tab.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .tint(currentTab == tab ? .purple : .gray)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            
            if tab == .cart,let amount = UserDefaults.standard.value(forKey: "amount") as? Double, amount != 0.0 {
                Circle()
                    .fill(.CBF_265)
                    .frame(width:20,height: 20)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .overlay(
                        Text("1")
                            .foregroundColor(.black)
                            .font(.customFont(family: .roboto, size: .size10))
                            .fontWeight(.bold)
                    )
                    .offset(x:7,y: -15)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
