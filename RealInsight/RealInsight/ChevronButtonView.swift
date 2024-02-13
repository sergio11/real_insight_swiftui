//
//  ChevronButtonView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct ChevronButtonView: View {
    
    var icon: String
    var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 45)
                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
            
            HStack {
                
                Image(systemName: icon)
                    .foregroundColor(.white)
                
                Text(text)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
            .frame(height: 30)
            
        }
    }

}

struct ChevronButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChevronButtonView(icon: "envelop", text: "Contact us")
    }
}
