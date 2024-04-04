//
//  MemoriesView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct MemoriesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    dismiss()
                }, title: "Memories", trailingActionContent: AnyView(Image(systemName: "questionmark.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 16))))
                VStack {
                    DeactivateMemoriesTitle()
                    DeactivateMemoriesBox()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50)
            }
        }
    }
}

private struct MainTitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Your memories are activated")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                Spacer()
            }
            Text("All your RealInsight are automatically added to your Memories and only visible by you")
                .foregroundColor(.white)
                .padding(.top, -2)
        }
    }
}


private struct DeactivateMemoriesTitle: View {
    var body: some View {
        HStack {
            Text("Deactivate and Delete Memories")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
            
            Spacer()
        }
    }
}

private struct DeactivateMemoriesBox: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 210)
                .foregroundColor(Color(red: 22/255, green: 4/255, blue: 3/255))
                .overlay(
                    RoundedRectangle(cornerRadius: 16).stroke(.red, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Deactivate and Delete Memories")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                VStack {
                    HStack {
                        Text("If you deactivate your Memories, all your RealInsights will be permanently deleted and unrecoverable")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                        Spacer()
                    }
                    HStack {
                        Text("All your future RealInsights won't be saved in Memories and will be automatically deleted as well.")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                        Spacer()
                    }
                }
                .padding(.top, -6)
                DeactivateMemoriesButton()
            }.padding(.leading)
        }
        .padding(.top, 22)
    }
}

private struct DeactivateMemoriesButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: UIScreen.main.bounds.width * 0.5, height: 40)
            .foregroundColor(Color(red: 44/255, green: 44/255, blue: 46/255))
            .overlay(
                Text("Deactivate Memories")
                    .foregroundColor(.red)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
            )
            .padding(.top, 8)
    }
}

struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView()
    }
}
