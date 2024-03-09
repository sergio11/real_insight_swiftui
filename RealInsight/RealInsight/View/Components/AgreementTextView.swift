//
//  AgreementTextView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 9/3/24.
//

import SwiftUI

struct AgreementTextView: View {
    var body: some View {
        Text("By tapping \"Continue\", you agree to our Privacy Policy and Terms of Service.")
            .foregroundColor(Color(red: 70/255, green: 70/255, blue: 73/255))
            .fontWeight(.semibold)
            .font(.system(size: 14))
            .multilineTextAlignment(.center)
    }
}

struct AgreementTextView_Previews: PreviewProvider {
    static var previews: some View {
        AgreementTextView()
    }
}
