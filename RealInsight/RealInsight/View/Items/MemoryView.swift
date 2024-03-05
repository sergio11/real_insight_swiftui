//
//  MemoryView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI

struct MemoryView: View {
    
    var day: Int
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(day)")
                    .foregroundColor(.white)
                    .zIndex(1)
                Image("example")
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

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView(day: 12)
    }
}
