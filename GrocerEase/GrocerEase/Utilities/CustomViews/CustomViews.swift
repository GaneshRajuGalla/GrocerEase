//
//  CustomViews.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation
import SwiftUI

// TODO: - SearchBarView

struct SearchBarView: ViewModifier{
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .padding(.leading, 40)
            .font(.customFont(family: .roboto, size: .size17))
            .frame(maxWidth: .infinity)
            .frame(height: 49)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.textFieldBorderColor, lineWidth: 1))
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            .tint(.black)
            .overlay(
                Image(.search)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading,14),
                alignment: .leading
            )
        
    }
}

// TODO: - CustomTextField

struct CustomTextField: ViewModifier{
    
    // MARK: - Properties
    
    let isHint:Bool
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .padding([.leading,.trailing])
            .font(.customFont(family: .roboto, size: .size18))
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
            .tint(.black)
            .overlay(isHint ?
                     Image(.hint)
                .resizable()
                .frame(width: 36, height: 26)
                .padding(.trailing, 10)
                     : nil,
                     alignment: .trailing
            )
    }
}

// TODO: - CustomButton

struct CustomButton:ViewModifier{
    
    // MARK: - Properties
    
    let backgroundColor: Color
    let foregroundColor:Color
    let buttonImage:UIImage?
    let cornerRadius:CGFloat
    let borderColor:Color?
    let borderWidth:CGFloat?
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        HStack{
            if let image = buttonImage{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            content
                .foregroundColor(foregroundColor)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor ?? .clear, lineWidth: borderWidth ?? 0)
        )
    }
}

// TODO: - TopRoundedRectangle
struct TopRoundedRectangle: Shape {
    
    // MARK: - Properties
    var radius: CGFloat
    
    // MARK: - path
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
