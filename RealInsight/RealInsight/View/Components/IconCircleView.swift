//
//  IconCircleView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/3/24.
//

import SwiftUI

struct IconCircleView: View {
    
    var iconName: String
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .frame(width: 34, height: 34)
                    .foregroundColor(.black)
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .opacity(0.1)
            }
            Image(systemName: iconName)
                .foregroundColor(.black)
                .font(.system(size: 16))
                .shadow(color: .white, radius: 1, x: 1, y: 1)
        }
    }
}

struct IconCircleView_Previews: PreviewProvider {
    static var previews: some View {
        IconCircleView(iconName: "camera.fill")
    }
}
