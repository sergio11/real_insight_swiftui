//
//  LeftMenuTopView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI

struct LeftMenuTopView: View {
    
    @State var text = ""
    @State var isEditing = false
    
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.forward")
                        .foregroundColor(.white)
                }
                
                Text("RealInsight")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
            }
            
            SearchBar(text: $text, isEditing: $isEditing)
            Spacer()
        }
    }
}

struct LeftMenuTopView_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenuTopView()
    }
}
