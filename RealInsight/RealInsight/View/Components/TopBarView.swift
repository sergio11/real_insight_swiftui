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
    var trailingActionContent: AnyView? = nil

    
    var body: some View {
        VStack {
            HStack {
                if let action = backButtonAction {
                    Button {
                        action()
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
                if let trailingActionContent = trailingActionContent {
                    trailingActionContent
                        .padding(.trailing)
                }
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
