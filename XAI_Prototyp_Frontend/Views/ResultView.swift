//
//  ResultView.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 06.03.25.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var ratingViewModel : RatingMoviesViewModel
    
    struct Constants {
        static let buttonWidth: CGFloat = 300
        static let buttonHeight: CGFloat = 25
        static let frameHeight: CGFloat = 200
        static let numberOfRecommendations: Int = 3
    }
    //https://stackoverflow.com/questions/69393430
    var body: some View {
        VStack (spacing: .paddingMedium) {
            titleView()
            if let recommendations = ratingViewModel.movieRecommendations {
                ForEach(Array(recommendations.enumerated()), id: \.element.id) { index, rec in
                    recommendedMovie(title: rec.Title, rating: rec.predicted_rating, index: index)
                }
            } else {
                loadingView()
            }
        }
        .padding(.paddingMedium)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton()
            }
        }
    }
    
    @ViewBuilder
    func titleView() -> some View {
        Text("DEINE TOP 3 EMPFEHLUNGEN")
            .font(.largeBold)
            .multilineTextAlignment(.leading)
    }
    @ViewBuilder
    func loadingView() -> some View {
        HStack {
            Text("Lade Empfehlungen...")
                .foregroundColor(.gray)
                .padding(.horizontal, .paddingMedium)
            ProgressView()
        }
    }
    @ViewBuilder
    func backButton()-> some View {
        Button(action: {
            ratingViewModel.cancelFetch()
            ratingViewModel.cleanRecommendations()
            router.goBack()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Meine Bewertungen")
                    .font(.medium)
            }
            .foregroundStyle(Color.black)
        }
    }
    @ViewBuilder
    func recommendedMovie(title: String,  rating: Double, index: Int) -> some View {
        VStack (alignment: .center, spacing: .paddingSmall) {
            Spacer()
            Text(title)
                .font(.largeBold)
            Text("Erwartete Bewertung: \(rating.oneDecimalNumbers)")
                .font(.medium)
                .padding(.bottom, .paddingMedium)
            Button(action: {
                ratingViewModel.selectedRecommandation = index
                router.navigate(to: .explanation)
            }){
                Text("Warum?")
                    .font(.mediumBold)
                    .scaledToFit()
                    .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                    .background(Color.white)
                    .foregroundColor(.lightBlue)
                    .cornerRadius(.cornerRadiusSmall)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.frameHeight)
        .background(Color.lightBlue)
        .cornerRadius(.cornerRadiusMedium)
    }
}
