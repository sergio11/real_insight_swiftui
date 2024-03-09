//
//  WhiteButtonView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct WhiteButtonView: View {
    
    @Binding var buttonActive: Bool
    var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                .foregroundColor(buttonActive ? Color(red: 250/255, green: 250/255, blue: 250/255) : Color(red: 86/255, green: 86/255, blue: 88/255))
            
            HStack {
                Spacer()
                Text(text)
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
            .frame(height: 30)
            
        }
    }
}

struct WhiteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        WhiteButtonView(buttonActive: .constant(true), text: "Save")
    }
}
