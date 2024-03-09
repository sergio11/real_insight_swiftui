//
//  TopBarView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct TopBarView: View {
    var backButtonAction: (() -> Void)? = nil
    var title: String = "RealInsights."
    var backButtomIcon: String = "arrow.backward"

    
    var body: some View {
        VStack {
            HStack {
                if backButtonAction != nil {
                    Button {
                        backButtonAction?()
                    } label: {
                        Image(systemName: backButtomIcon)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }.padding(.leading)
                }
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                Spacer()
            }
            Spacer()
        }
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
