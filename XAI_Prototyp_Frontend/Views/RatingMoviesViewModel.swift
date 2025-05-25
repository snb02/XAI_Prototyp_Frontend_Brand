//
//  QuestionViewModel.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 06.03.25.
//

import Foundation
import SwiftUI

class RatingMoviesViewModel : ObservableObject {
    @Published public var userName: String = ""
    @Published public var selectedRecommandation: Int? = nil
    @Published var detailgrad : Detailgrad = .easy
    @Published public var ratings: [String: Double] = ["Inception": 5.0, "Harry Potter und der Stein der Weisen": 5.0, "Die Eiskönigin – Völlig unverfroren": 5.0, "Forrest Gump": 5.0, "Stirb langsam": 5.0, "Joker": 5.0, "Stranger Things": 5.0, "Modern Family": 5.0, "Rick and Morty": 5.0, "The Big Bang Theory": 5.0 ] 
    @Published var movieRecommendations: [MovieRecommendation]?
    @Published var counterfactualTexts: [CounterfactualText]?
    @Published var limeImages: [UIImage]?
    @Published var historyValues: [HistoryValues]?
    @Published var limeValues: [LimeValues]?
    @Published var lossImage: UIImage?
    @Published var isLoading: Bool = true
    
    var fetchTask: Task<Void, Never>?
    
    //http://stackoverflow.com/questions/74318352/publishing-changes-from-background-threads-is-not-allowed-make-sure-to-publish
    //https://www.ralfebert.de/ios-app-entwicklung/swiftui-async-await-tutorial/
    @MainActor
    func fetchRecommendationsAndExplanations() {
        isLoading = true
        fetchTask = Task {
            await NetworkViewModel.postRatings(ratings: ratings)
            movieRecommendations = try? await NetworkViewModel.fetchTop3Recommendations()
            limeImages = try? await NetworkViewModel.fetchLimeImages()
            counterfactualTexts = try? await NetworkViewModel.fetchCounterfactualText()
            historyValues = try? await NetworkViewModel.fetchHistoryValues()
            limeValues = try? await NetworkViewModel.fetchLimeValues()
            lossImage = try? await NetworkViewModel.fetchHistoryImage()
            if counterfactualTexts != nil,
               limeValues != nil,
               limeImages != nil,
               historyValues != nil,
               lossImage != nil{
                isLoading = false
            }
        }

    }
    //https://www.hackingwithswift.com/quick-start/concurrency/how-to-cancel-a-task
    func cancelFetch() {
        fetchTask?.cancel()
        fetchTask = nil
    }
    
    func cleanRecommendations() {
        movieRecommendations = nil
        counterfactualTexts = nil
        limeImages = nil
        historyValues = nil
        limeValues = nil
        isLoading = true
    }
    
    //https://www.hackingwithswift.com/example-code/strings/replacing-text-in-a-string-using-replacingoccurrencesof
    func convertToReadableString(string: String) -> String {
        
        if string.contains("Releaseyear") {
            if string.contains("< ") && string.contains("<=") {
                let wortArray = string.components(separatedBy: " ")
                return "Releaseyear ist zwischen \(String(describing: wortArray.first ?? "")) und \(String(wortArray.last ?? ""))"
            }
            if string.contains("<=") {
                return string.replacingOccurrences(of: "<=", with: "ist kleiner oder gleich")
            }
            if string.contains(">=") {
                return string.replacingOccurrences(of: ">=", with: "ist größer oder gleich")
            }
            if string.contains("<") {
                return string.replacingOccurrences(of: "<", with: "ist kleiner als")
            }
            if string.contains(">") {
                return string.replacingOccurrences(of: ">", with: "ist größer als")
            }
            if string.contains("=") {
                return string.replacingOccurrences(of: "=", with: "ist gleich")
            }
        }
        
        if string.contains("Genre") || string.contains("Topic") || string.contains("Typ") {
            if string.contains("0.00 <") && string.contains("<= 1.00") {
                let firstString = string.replacingOccurrences(of: "0.00 <", with: "")
                let secondString = firstString.replacingOccurrences(of: "<= 1.00", with: "")
                return secondString + " ist gegegben"
            }
            if string.contains("0.00 <=") && string.contains("< 1.00") {
                let firstString = string.replacingOccurrences(of: "0.00 <=", with: "")
                let secondString = firstString.replacingOccurrences(of: "> 1.00", with: "")
                return secondString + " ist nicht gegeben"
            }
            if string.contains(">=") {
                return string.replacingOccurrences(of: ">= 0.00", with: "ist gegeben")
            }
            if string.contains("<=") {
                return string.replacingOccurrences(of: "<= 0.00", with: "ist nicht gegeben")
            }
            if string.contains("<") {
                return string.replacingOccurrences(of: "< 0.00", with: "ist nicht gegeben")
            }
            if string.contains(">") {
                return string.replacingOccurrences(of: "> 0.00", with: "ist gegeben")
            }
        }
        return string
    }
}

//http://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/
enum Detailgrad: String, CaseIterable {
    case easy = "Einfach"
    case middle = "Mittel"
    case hard = "Schwer"
}
