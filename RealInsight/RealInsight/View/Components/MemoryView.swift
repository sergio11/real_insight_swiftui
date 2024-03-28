//
//  MemoryView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI
import Kingfisher

struct MemoryView: View {
    
    var realInsight: RealInsight
    
    var body: some View {
        VStack {
            ZStack {
                Text(realInsight.createdAt.dayOfMonth())
                    .foregroundColor(.white)
                    .zIndex(1)
                KFImage(URL(string: realInsight.backImageUrl))
                    .resizable()
                    .placeholder {
                        LoadingView()
                    }
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 8, height: 70)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                        .stroke(.white, lineWidth: 1.5)
                        .frame(width: UIScreen.main.bounds.width / 8, height: 70))
            }
        }
    }
}
