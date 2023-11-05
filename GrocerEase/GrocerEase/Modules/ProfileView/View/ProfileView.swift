//
//  ProfileView.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 15){
            Image(.ganesh)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width:200,height: 200)
                .shadow(radius: 10)
            
            Text("Ganesh Raju Galla")
                .font(.customFont(family: .roboto, size: .size25))
                .fontWeight(.bold)
                .foregroundStyle(.black)
            
            Text("iOS Developer")
                .font(.customFont(family: .roboto, size: .size20))
                .fontWeight(.regular)
                .foregroundStyle(.black)
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
