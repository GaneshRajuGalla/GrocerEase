//
//  AsyncImageView.swift
//  GrocerEase
//
//  Created by Ganesh on 05/11/23.
//

import Foundation
import SwiftUI

struct AsyncImageView: View {
    
    // MARK: - Properties
    
    let urlString:String?
    
    // MARK: - Body
    
    var body: some View {
        AsyncImage(url: URL(string: urlString ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
    }
}
