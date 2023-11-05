//
//  RootView.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI

struct RootView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var manager:NavigationManager
    
    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom,content: {
            TabView(selection: $manager.selectedTab,
                    content:  {
                CategoriesView()
                    .tag(TabItems.categories)
                ConfirmationView()
                    .tag(TabItems.cart)
                ProfileView()
                    .tag(TabItems.profile)
            })
            CustomTabBar(currentTab: $manager.selectedTab)
        })
    }
}


#Preview {
    RootView()
}
