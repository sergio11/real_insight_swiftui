//
//  NoDataFoundView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 3/4/24.
//

import Foundation
import SwiftUI

struct NoDataFoundView: View {
    
    var title: String
    var description: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 18)
            .frame(width: UIScreen.main.bounds.width * 0.95, height: 90)
            .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
            .overlay(
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Text(title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(description)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
            )
    }
}
