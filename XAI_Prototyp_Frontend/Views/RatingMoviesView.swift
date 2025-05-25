//
//  QuestionView.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 06.03.25.
//

import SwiftUI

struct RatingMoviesView: View {
    @EnvironmentObject var router : Router
    @ObservedObject var viewModel : RatingMoviesViewModel
    @State private var selectedMovie = 0
    
    struct Constants {
        static let movieFrameWidth: CGFloat = 240
        static let movieFrameHeight: CGFloat = 350
        static let defaultRating: CGFloat = 350
        static let buttonWidth: CGFloat = 270
        static let buttonHeight: CGFloat = 50
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .paddingMedium){
            textHeaderView()
            movieTabView()
            Spacer()
            ratingSlider()
            Spacer()
            finishedButton()
        }
        .padding(.horizontal, .paddingMedium)
        .padding(.top, .paddingMedium)
        .navigationBarBackButtonHidden(true)
    }
    @ViewBuilder
    func textHeaderView() -> some View {
        Text("Hey \(viewModel.userName), \nwelche Filme magst du am liebsten? ")
            .font(Font.xLargeBold)
        Text("Bitte Bewerte alle 10 Filme")
            .font(Font.medium)
    }
    //https://stackoverflow.com/questions/65690484/enumerated-method-not-working-on-array
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-scrolling-pages-of-content-using-tabviewstyle
    @ViewBuilder
    func movieTabView() -> some View {
        TabView(selection: $selectedMovie) {
            ForEach(Array(viewModel.ratings.keys.enumerated()), id: \.1) { index, title in
                ZStack {
                    Text(title)
                        .font(Font.large)
                        .padding(.horizontal)
                        .frame(width: Constants.movieFrameWidth, height: Constants.movieFrameHeight)
                        .multilineTextAlignment(.center)
                        .background(Color.lightBlue)
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page)
    }
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-custom-bindings
    @ViewBuilder
    func ratingSlider() -> some View {
        let movieKeys = Array(viewModel.ratings.keys)
        if selectedMovie < movieKeys.count {
            let movie = movieKeys[selectedMovie]
            let binding = Binding<Double>(
                get: { viewModel.ratings[movie] ?? Constants.defaultRating },
                set: { newValue in
                    viewModel.ratings[movie] = newValue.roundToNextHalf
                }
            )
            VStack(alignment: .leading){
                Text("Deine Bewertung: \((viewModel.ratings[movie] ?? Constants.defaultRating).oneDecimalNumbers)")
                HStack {
                    Text("0")
                    Slider(value: binding, in: 0...10, step: 0.1)
                        .padding(.horizontal, .paddingSmall)
                        .tint(Color.lightBlue)
                    Text("10")
                }
            }
            .font(Font.medium)
        }
    }
    @ViewBuilder
    func finishedButton() -> some View {
        HStack {
            Spacer()
            Button(action: {
                router.navigate(to: .result)
                viewModel.fetchRecommendationsAndExplanations()
            }) {
                Text("FERTIG")
                    .font(Font.largeBold)
                    .foregroundStyle(Color.white)
                    .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                    .background(Color.lightBlue)
                    .cornerRadius(.cornerRadiusBig)
            }
            Spacer()
        }
        .padding(.bottom, .paddingBig)
    }
}
