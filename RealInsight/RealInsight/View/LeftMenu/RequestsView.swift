//
//  RequestsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct RequestsView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 65)
                        .foregroundColor(Color(red: 40/255, green: 40/255, blue: 35/255))
                        .overlay(
                            HStack {
                                Image("example")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("Invite friends on RealInsights")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    Text("realinsight/dreamsoftware")
                                        .foregroundColor(.gray)
                                    
                                }
                                Spacer()
                                
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                            }
                                .padding(.horizontal)
                        )
                        .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Text("FINDING REQUESTS (21)")
                                .foregroundColor(Color(red: 205/255, green: 204/255, blue: 209/255))
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                            Spacer()
                            
                            HStack {
                                Text("Sent")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 18)
                            .frame(width: UIScreen.main.bounds.width * 0.95, height: 90)
                            .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
                            .overlay(
                                VStack(spacing: 8) {
                                    HStack {
                                        Spacer()
                                        Text("No pending requests")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Text("You don't have any pending requests.")
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                }
                            )
                        
                    }.padding(.top)
                    Spacer()
                }.padding(.top, 20)
            }
            .padding(.top, 110)
        }
    }
}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        RequestsView()
    }
}
