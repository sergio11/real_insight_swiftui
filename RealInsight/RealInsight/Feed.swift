//
//  Feed.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ZStack {
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(.white)
                            Spacer()
                            Text("RealInsight.")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 22))
                            Spacer()
                            Image("example")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .cornerRadius(17.5)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("My friends")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            
                            Text("Discovery")
                                .foregroundColor(.gray)
                    
                        }
                        
                        Spacer()
                        
                        
                    }
                }
            }
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
