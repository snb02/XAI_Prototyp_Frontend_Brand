//
//  ExplainView.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 06.03.25.
//

import SwiftUI
import Charts

struct ExplanationView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var ratingViewModel : RatingMoviesViewModel
    
    struct Constants {
        static let recommendMovieFrameHeight: CGFloat = 115
        static let movieFrameHeight: CGFloat = 350
        static let defaultRating: CGFloat = 350
        static let chartHeight:CGFloat = 150
        static let detailPickerWidth:CGFloat = 340
        static let detailPickerHeight:CGFloat = 50
        static let singlePickerWidth: CGFloat = 100
        static let singlePickerHeight: CGFloat = 36
    }
    
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toolbar-and-add-buttons-to-it
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .paddingMedium){
                if let movies = ratingViewModel.movieRecommendations,
                   let selected = ratingViewModel.selectedRecommandation {
                    ForEach(movies.indices, id: \.self) { index in
                        if index == selected {
                            recommendedMovie(title: movies[index].Title, rating: movies[index].predicted_rating)
                        }
                    }
                }
                if ratingViewModel.isLoading {
                    HStack{
                        Text("Lade Erklärungen...")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        ProgressView()
                    }
                }else {
                    explanation()
                }
            }
            .padding(.paddingMedium)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton()
            }
            if ratingViewModel.detailgrad == .easy || ratingViewModel.detailgrad == .middle{
                ToolbarItem(placement: .navigationBarTrailing) {
                    helpButton()
                }
            }
            ToolbarItem(placement: .bottomBar) {
                detailPicker()
            }
        }
        .toolbarBackground(.hidden, for: .bottomBar)
    }
    @ViewBuilder
    func backButton()-> some View {
        Button(action: {
            router.goBack()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Meine Empfehlungen")
                    .font(.medium)
            }
            .foregroundStyle(Color.black)
        }
    }
    //https://www.flaticon.com/de/kostenloses-icon/idee_427735
    @ViewBuilder
    func helpButton()-> some View {
        HStack {
            Spacer()
            Button(action: {
                router.navigate(to: .help)
            }){
                Image("lightBulb")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    @ViewBuilder
    func recommendedMovie(title: String,  rating: Double) -> some View {
        HStack{
            VStack(alignment: .leading, spacing: .paddingSmall) {
                Text("Filmempfehlung:")
                    .font(Font.medium)
                Text(title)
                    .font(Font.largeBold)
            }
            .padding(.horizontal)
            Spacer()
            Text("\(rating.oneDecimalNumbers)")
                .font(.xLarge)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.recommendMovieFrameHeight)
        .background(Color.lightBlue)
        .cornerRadius(.cornerRadiusMedium)
    }
    
    @ViewBuilder
    func explanation()-> some View {
        VStack (alignment: .leading, spacing: .paddingSmall) {
            Text("ERKLÄRUNG:")
                .font(Font.largeBold)
                .padding(.bottom, .paddingSmall)
            switch ratingViewModel.detailgrad {
            case .easy:
                easyExplanation()
                explainAIButton()
            case .middle:
                easyExplanation()
                middleExplanation()
            case .hard:
                hardExplanation()
                middleExplanation()
                easyExplanation()
            }
        }
    }
    //https://www.appcoda.com/swiftui-chart-ios17/
    @ViewBuilder
    func easyExplanation()-> some View {
        if let explanations = ratingViewModel.counterfactualTexts{
            Text("Was wäre, wenn: \nAuswirkungen der Merkmale")
                .font(Font.largeBold)
            Text("\(explanations[ratingViewModel.selectedRecommandation ?? 0].explanations)")
                .font(Font.medium)
                .lineSpacing(.lineSpacing)
        }
        VStack(alignment: .leading, spacing: .paddingSmall){
            Text("Einflussreiche Merkmale auf die Bewertung (positiv):")
                .font(Font.largeBold)
            
            let positiveFeatures = ratingViewModel.limeValues?.filter {
                $0.index == ratingViewModel.selectedRecommandation && $0.importance > 0
            } ?? []
            if positiveFeatures.isEmpty {
                Text("Es gibt keine Merkmale mit positivem Einfluss auf die Bewertung")
            } else {
                Chart {
                    if let limeValues = ratingViewModel.limeValues {
                        ForEach(limeValues, id: \.feature) { element in
                            if element.index == ratingViewModel.selectedRecommandation {
                                if element.importance > 0 {
                                    BarMark(
                                        x: .value("Importance", element.importance),
                                        y: .value("Feature", "")
                                    )
                                    .foregroundStyle(by: .value("Type", ratingViewModel.convertToReadableString(string: element.feature)))
                                }
                            }
                        }
                    }
                }
                .frame(height: Constants.chartHeight)
            }
        }
        .padding(.vertical, .paddingMedium)
    }
    
    @ViewBuilder
    func middleExplanation() -> some View {
        if let selected = ratingViewModel.selectedRecommandation,
           let images = ratingViewModel.limeImages,
           selected < images.count {
            VStack(alignment: .leading, spacing: .paddingSmall){
                Text("Einflussreiche Merkmale auf die Bewertung (positiv/negativ):")
                    .font(Font.largeBold)
                Image(uiImage: images[ratingViewModel.selectedRecommandation ?? 0])
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(.cornerRadiusSmall)
                    .shadow(radius: .radius)
            }
            .padding(.vertical,.paddingMedium)
        }
    }
    //https://stackoverflow.com/questions/69393430
    @ViewBuilder
    func hardExplanation()-> some View {
        VStack(alignment: .leading){
            Text("Trainingsdaten:")
                .font(Font.largeBold)
                .padding(.bottom, .paddingSmall)
            ForEach(ratingViewModel.historyValues ?? [], id: \.name) { element in
                HStack{
                    Text("\(element.name): ")
                        .font(Font.mediumBold)
                    Text("\(element.values.threeDecimalNumbers)")
                        .font(Font.medium)
                }
            }
            Image(uiImage: ratingViewModel.lossImage ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(.cornerRadiusSmall)
                .shadow(radius: .radius)
                .padding(.top, .paddingSmall)
        }
    }
    
    @ViewBuilder
    func explainAIButton()-> some View {
        Button(action: {
                router.navigate(to: .ki)
            }) {
                ZStack(alignment: .leading){
                    Image("kiButton")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .shadow(color: .gray, radius: .radius, x: .radius, y: .radius)
                    Text("Wie funkioniert Künstliche Intelligenz?")
                        .font(Font.small)
                        .foregroundColor(.black)
                        .padding(.leading, .paddingMedium)
                }
            }
    }
   //http://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/
    @ViewBuilder
    func detailPicker()-> some View {
        HStack {
            Spacer()
            HStack (spacing: .paddingSmall){
                ForEach(Detailgrad.allCases, id: \.self) { difficulty in
                    Button(action: {
                        if let grad = Detailgrad(rawValue: difficulty.rawValue) {
                            ratingViewModel.detailgrad = grad
                        }
                    }) {
                        Text(difficulty.rawValue)
                            .font(Font.mediumBold)
                            .scaledToFit()
                            .frame(width: Constants.singlePickerWidth, height:  Constants.singlePickerHeight)
                            .background(ratingViewModel.detailgrad.rawValue == difficulty.rawValue ? Color.lightBlue : Color.white)
                            .foregroundColor(ratingViewModel.detailgrad.rawValue == difficulty.rawValue ? .white : Color.lightBlue)
                            .cornerRadius(.cornerRadiusMedium)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            .frame(width: Constants.detailPickerWidth, height: Constants.detailPickerHeight)
            .background(Color.white)
            .cornerRadius(.cornerRadiusBig)
            .shadow(color: .gray, radius: .radius, x: .radius, y: .radius)
            Spacer()
        }
    }
}
