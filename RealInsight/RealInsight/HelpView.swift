//
//  HelpView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Text("Help")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
                
                VStack {
                    
                    VStack(spacing: 16) {
                        ChevronButtonView(icon: "envelop", text: "Contact us")
                        ChevronButtonView(icon: "questionmark.circle", text: "Help Center")
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)
                    
                }
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
