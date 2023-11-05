//
//  View.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation
import SwiftUI

extension View {
    
    func withCustomButton(_ backgroundColor:Color, _ foregroundColor:Color, _ buttonImage:UIImage?,_ cornerRadius: CGFloat,_ borderColor:Color?,_ borderWidth:CGFloat? ) -> some View{
        modifier(CustomButton(backgroundColor: backgroundColor, foregroundColor: foregroundColor, buttonImage: buttonImage, cornerRadius: cornerRadius,borderColor: borderColor ,borderWidth: borderWidth))
    }
    
    func withCustomEffect(_ scaleEffect:CGFloat = 0.9) -> some View{
        buttonStyle(CustomEffect(scaleEffect: scaleEffect))
    }
    
    func withCustomTextFields(isHint:Bool = false) -> some View{
        modifier(CustomTextField(isHint: isHint))
    }
}

struct CustomEffect: ButtonStyle{
    let scaleEffect: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleEffect : 1.0)
            .opacity(configuration.isPressed ? 0.93 : 1.0 )
    }
}
