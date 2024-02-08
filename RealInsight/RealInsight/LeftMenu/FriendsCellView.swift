//
//  FriendsCellView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/2/24.
//

import SwiftUI

struct FriendsCellView: View {
    var body: some View {
        HStack {
            Image("example")
                .resizable()
                .scaledToFit()
                .frame(width: 65, height: 65)
                .cornerRadius(65/2)
            
            VStack(alignment: .leading) {
                Text("Sergio")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text("dreamsoftware")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .padding(.leading, 6)
            
        }.padding(.horizontal)
    }
}

struct FriendsCellView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsCellView()
    }
}
