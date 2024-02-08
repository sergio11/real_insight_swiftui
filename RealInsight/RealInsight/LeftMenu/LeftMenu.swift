//
//  LeftMenu.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI

struct LeftMenu: View {
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                LeftMenuTopView()
                Suggestions()
            }
        }
    }
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu()
    }
}
