//
//  AccountCreatedView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct AccountCreatedView: View {
    
    @Binding var isAccountCreated: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AccountCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreatedView(isAccountCreated: .constant(false))
    }
}
