//
//  LaunchScreen.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI

struct LaunchScreen: View {
    
    // MARK: - Properties
    
    @State private var mass: Double = 2
    @State private var stiffness: Double = 100
    @State private var damping: Double = 13
    @State private var initialVelocity: Double = 2
    @State private var moveLogo = false
    @State private var logoOpacity: Double = 0.0

    
    // MARK: - Body
    
    var body: some View {
        ZStack{
            if logoOpacity == 1{
                HomeScreen()
            }else{
                LinearGradient(colors: [.B_495_D_6,._6_A_359_C], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
               Text("GrocerEase")
                    .font(.customFont(family: .roboto, size: .size34))
                    .foregroundStyle(.white)
                    .fontWeight(.black)
                
                Image(systemName: "cart.circle")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    .frame(width: 120,height: 120)
                    .offset(y: moveLogo ? 150 : 500)
                    .animation(Animation.interpolatingSpring(mass: mass, stiffness: stiffness, damping: damping, initialVelocity: initialVelocity), value: moveLogo)
            }
        }
        .onAppear {
            moveLogo.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeIn(duration: 1.2)) {
                    initialVelocity = 4
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                withAnimation(.easeIn(duration: 0.6)) {
                    moveLogo.toggle()
                    logoOpacity = 0.5
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeIn(duration: 1.0)) {
                    logoOpacity = 1
                }
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
