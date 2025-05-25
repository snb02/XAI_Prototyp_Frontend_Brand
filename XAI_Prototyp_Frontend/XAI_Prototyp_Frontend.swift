//
//  MovieRecommendationWithXAIApp.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 03.03.25.
//

import SwiftUI

//https://medium.com/@oguzoozer/swiftui-router-implementation-a-deep-dive-into-clean-architecture-navigation-690c06d8db05

@main
struct XAI_Prototyp_Frontend: App {
    @StateObject var ratingViewModel = RatingMoviesViewModel()
    var helpViewModel = HelpViewModel()
    var aiViewModel = ExplanationAIViewModel()
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                OnboardingView(viewModel: ratingViewModel)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .rating:
                            RatingMoviesView(viewModel: ratingViewModel)
                        case .result:
                            ResultView(ratingViewModel: ratingViewModel)
                        case .explanation:
                            ExplanationView(ratingViewModel: ratingViewModel )
                        case .ki:
                            ExplanaitionAIView(viewModel: aiViewModel)
                        case .help:
                            HelpView(viewModel: helpViewModel)
                        case .licenses:
                            LicensesView()
                        }
                    }
                    .navigationBarBackButtonHidden(true)
            }
            .environmentObject(router)
        }
    }
}
