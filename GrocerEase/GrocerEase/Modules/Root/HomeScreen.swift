//
//  HomeScreen.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI

struct HomeScreen: View {
    
    //  MARK: - Properties
    
    @EnvironmentObject var manager:NavigationManager
    @State private var isPresented:Bool = true
    
    // MARK: -  Body
    
    var body: some View {
        ZStack {
            if !isPresented{
                RootView()
            }else{
                LinearGradient(gradient: Gradient(stops: [
                    .init(color: .customPurple, location: 0.0342),
                    .init(color: .customViolet, location: 0.2135),
                    .init(color: .customWhite, location: 0.6823),
                    .init(color: .customClear, location: 0.9996)
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Image(.launchScreenBG)
                    .resizable()
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isPresented, onDismiss: {
            
        }, content: {
            nonContactDeleveryView()
                .presentationCornerRadius(50)
                .presentationDetents([.medium])
                .presentationBackground(.EEEEEE)
        })
        
    }
}

extension HomeScreen{
    
    // TODO: - NonContactDeleveryView
    
    func nonContactDeleveryView() -> some View{
        VStack(spacing: 30){
            ZStack{
                Circle()
                    .stroke(Color.gray,lineWidth: 1)
                    .foregroundStyle(.white)
                    .frame(width: 91,height: 91)
                Image(.box)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40,height: 40)
            }
            
            Text(verbatim: .nonContactDeliveries)
                .font(.customFont(family: .roboto, size: .size34))
                .foregroundStyle(.black)
                .fontWeight(.bold)
            
            Text(verbatim: .nonContactDesp)
                .font(.customFont(family: .roboto, size: .size17))
                .foregroundStyle(._9586_A_8)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            Button(action: {
                withAnimation(.bouncy) {
                    isPresented = false
                }
            }, label: {
                Text(verbatim: .orderNow)
                    .withCustomButton(._0_BCE_83, .white, nil, 15, .borderColor, 1)
            })
            .withCustomEffect()
            
            Button {
                withAnimation(.bouncy) {
                    isPresented = false
                }
            } label: {
                Text(verbatim: .dismiss)
                    .withCustomButton(.white, .black, nil, 15, nil, nil)
            }
            .withCustomEffect()
        }
        .padding()
    }
}
