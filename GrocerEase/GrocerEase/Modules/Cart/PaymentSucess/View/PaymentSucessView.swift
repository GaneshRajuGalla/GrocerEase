//
//  PaymentSucessView.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import SwiftUI

struct PaymentSucessView: View {
    
    //  MARK: - Properties
    
    @EnvironmentObject var manager:NavigationManager
    @State private var isPresented:Bool = true
    
    // MARK: -  Body
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .customPurple, location: 0.0342),
                .init(color: .customViolet, location: 0.2135),
                .init(color: .customWhite, location: 0.6823),
                .init(color: .customClear, location: 0.9996)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            Image(.launchScreenBG)
                .resizable()
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isPresented, onDismiss: {
            manager.cartRoutes.removeAll()
            manager.selectedTab = .categories
        }, content: {
            WishingView()
                .presentationCornerRadius(50)
                .presentationDetents([.medium])
                .presentationBackground(.EEEEEE)
        })
        .navigationBarBackButtonHidden(true)
        
    }
}



extension PaymentSucessView{
    
    // TODO: - WishingView
    
    func WishingView() -> some View{
        VStack{
            VStack(spacing: 60){
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
                Text(verbatim: .thankyou)
                    .font(.customFont(family: .roboto, size: .size34))
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            VStack(spacing: 20){
                Button(action: {
                    withAnimation(.bouncy) {
                        isPresented.toggle()
                    }
                }, label: {
                    Text(verbatim: .orderMore)
                        .withCustomButton(._0_BCE_83, .white, nil, 15, .borderColor, 1)
                })
                .withCustomEffect()
                
                Button {
                    withAnimation(.bouncy) {
                        isPresented.toggle()
                    }
                } label: {
                    Text(verbatim: .close)
                        .withCustomButton(.white, .black, nil, 15, nil, nil)
                }
                .withCustomEffect()
            }
        }
        .padding()
    }
}
