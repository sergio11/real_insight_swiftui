//
//  FeedCell.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {

    private var hasOwnRealInsightPublished: Bool
    @StateObject var viewModel: FeedCellViewModel
    
    init(realInsight: RealInsight, hasOwnRealInsightPublished: Bool) {
        self.hasOwnRealInsightPublished = hasOwnRealInsightPublished
        _viewModel = StateObject(wrappedValue: FeedCellViewModel(realInsight: realInsight))
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading) {
                HeaderView(authorProfileImageUrl: viewModel.authorProfileImageUrl, authorUsername: viewModel.authorUsername, authorFullname: viewModel.authorFullname)
                VStack(alignment: .leading) {
                    ZStack {
                        ZStack {
                            ActionsView()
                            PreviewView(realInsightBackImageUrl: viewModel.realInsightBackImageUrl, realInsightFrontImageUrl: viewModel.realInsightFrontImageUrl)
                        }.blur(radius: hasOwnRealInsightPublished ? 0 : 8)
                        if !hasOwnRealInsightPublished {
                            LockedView()
                        }
                    }
                    if hasOwnRealInsightPublished {
                        AddCommentView()
                    }
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: 600)
    }
}

private struct HeaderView: View {
    
    var authorProfileImageUrl: String
    var authorUsername: String
    var authorFullname: String
    
    var body: some View {
        HStack {
            ProfileImageView(
                size: 40,
                profileImageUrl: authorProfileImageUrl,
                fullName: authorUsername
            )
            VStack(alignment: .leading) {
                Text(authorFullname)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                Text("Published 7 hrs late")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
            }
            Spacer()
            ThreeDots(size: 4, color: .gray)
        }.padding(.horizontal)
    }
}


private struct AddCommentView: View {
    var body: some View {
        Text("Add a comment...")
            .foregroundColor(.gray)
            .fontWeight(.semibold)
            .padding(.leading)
    }
}

private struct PreviewView: View {
    
    var realInsightBackImageUrl: String
    var realInsightFrontImageUrl: String
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: realInsightBackImageUrl))
                .resizable()
                .placeholder {
                    LoadingView()
                }
                .frame(width: UIScreen.main.bounds.width)
                .scaledToFit()
                .cornerRadius(20)
        }
        
        GeometryReader { g in
            VStack {
                HStack {
                    KFImage(URL(string: realInsightFrontImageUrl))
                        .resizable()
                        .placeholder { LoadingView() }
                        .frame(width: 100, height: 160)
                        .scaledToFill()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 3)
                        )
                        .padding(.leading)
                    Spacer()
                }
                .padding(.top, 18)
                Spacer()
            }
        }
    }
}

private struct ActionsView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "bubble.left.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .shadow(color: .black, radius: 3, x: 1, y: 1)
                    Image(systemName: "face.smiling.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .shadow(color: .black, radius: 3, x: 1, y: 1)
                        .padding(.top, 15)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 50)
            }
        }.zIndex(1)
    }
}

private struct LockedView: View {
    var body: some View {
        VStack {
            Image(systemName: "eye.slash.fill")
                .foregroundColor(.white)
                .font(.system(size: 30))
            Text("Post to view")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .padding(.top, 4)
            Text("To view your friends' RealInsight, share yours with them.")
                .foregroundColor(.white)
                .font(.system(size: 14))
                .padding(.top, -4)
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .frame(width: 180, height: 40)
                .overlay(
                    Text("Post a Late RealInsight")
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                )
                .padding(.top, 6)
        }
    }
}
