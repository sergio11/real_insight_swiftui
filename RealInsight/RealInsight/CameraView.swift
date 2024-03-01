//
//  CameraView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 1/3/24.
//

import SwiftUI

struct CameraView: View {
    
    @State private var switchingCamera: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Text("RealInsight.")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    Text("04:57:11")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                        .overlay(
                            VStack {
                                ProgressView()
                                Text("Wait, wait, wait, now smile")
                            }
                                .foregroundColor(.white)
                                .opacity(self.switchingCamera ? 1 : 0)
                        )
                    
                    VStack {
                        HStack(alignment: .center, spacing: 18) {
                            Image(systemName: "bolt.slash.fill")
                                .font(.system(size: 28))
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "circle")
                                    .font(.system(size: 70))
                            }
                            
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 24))
                        }.foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.top, 50)
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
