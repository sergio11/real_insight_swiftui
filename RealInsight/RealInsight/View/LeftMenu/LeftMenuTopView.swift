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
    
    @Binding var isOpened: Bool
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            self.isOpened = false
                        }
                    } label: {
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white)
                    }
                }
                Text("RealInsight")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
            }.padding(.horizontal)
            SearchBar(text: $text, isEditing: $isEditing)
            Spacer()
        }
    }
}

struct LeftMenuTopView_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenuTopView(isOpened: .constant(true))
    }
}
