//
//  BackgroundImage.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 27/3/24.
//

import SwiftUI

struct BackgroundImage: View {
    let imageName: String
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Color.black.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
