//
//  Network.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 02.05.25.
//

import Foundation
import SwiftUI

//https://www.avanderlee.com/concurrency/urlsession-async-await-network-requests-in-swift/
//https://www.ralfebert.de/ios-app-entwicklung/swiftui-async-await-tutorial/
//https://www.hackingwithswift.com/forums/swift/base64-decoded-content-is-nil/7763

class NetworkViewModel: ObservableObject {
    static func postRatings(ratings: [String: Double]) async {
        guard let url = URL(string: "http://127.0.0.1:8000/ratings") else { //(eigene IP-Adresse):8000/ratings
            print("Invalid URL")
            return
        }
        
        for rating in ratings {
            let singleRating = Rating(movie: rating.key, ratingNumber: rating.value)
            let jsonData = try? JSONEncoder().encode(singleRating)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            do {
                let _ = try await URLSession.shared.data(for: request)
            } catch {
                print("Ratings Error: \(error.localizedDescription)")
            }
        }
    }
    static func fetchTop3Recommendations() async throws -> [MovieRecommendation] {
        guard let url = URL(string: "http://127.0.0.1:8000/top3") else { //oder eigene IP-Adresse
            print("Invalid URL")
            return []
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(Top3Response.self, from: data)
            
            return response.movieRecommendation
        } catch {
            print("Recommendations Error: \(error.localizedDescription)")
            return []
        }
    }
    static func fetchLimeImages() async throws -> [UIImage] {
        guard let url = URL(string: "http://127.0.0.1:8000/limeImages") else { //oder eigene IP-Adresse
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(LimeResponse.self, from: data)
            
            let limeImages: [UIImage] = decoded.lime_images.compactMap { lime in
                guard let base64 = lime.image,
                      let imageData = Data(base64Encoded: base64),
                      let image = UIImage(data: imageData) else {
                    return nil
                }
                return image
            }
            return limeImages
        } catch {
            print("Lime Image Error: \(error.localizedDescription)")
            return []
        }
    }
    static func fetchCounterfactualText () async throws -> [CounterfactualText] {
        guard let url = URL(string: "http://127.0.0.1:8000/counterfactualTexts") else { //oder eigene IP-Adresse
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(CounterfactualResponse.self, from: data)
            
            return response.counterfactualExplanations
        } catch {
            print("Counterfactual Text Error: \(error.localizedDescription)")
            return []
        }
    }
    static func fetchHistoryValues () async throws -> [HistoryValues] {
        guard let url = URL(string: "http://127.0.0.1:8000/historyValues") else { //oder eigene IP-Adresse
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(HistoryResponse.self, from: data)
            
            return response.historyValues
        } catch {
            print("History Value Error: \(error.localizedDescription)")
            return []
        }
    }
    static func fetchLimeValues () async throws -> [LimeValues] {
        guard let url = URL(string: "http://127.0.0.1:8000/limeValues") else { //oder eigene IP-Adresse
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(LimeValuesResponse.self, from: data)
            
            return response.limeValues
        } catch {
            print("Lime Value Error: \(error.localizedDescription)")
            return []
        }
    }
    static func fetchHistoryImage() async throws -> UIImage {
        guard let url = URL(string: "http://127.0.0.1:8000/lossImage") else { //oder eigene IP-Adresse
            print("Invalid URL")
            return UIImage()
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(HistoryImageResponse.self, from: data)

            if let base64 = decoded.lossImage,
               let imageData = Data(base64Encoded: base64),
               let image = UIImage(data: imageData) {
                return image
            }else {
                print("Error:")
                return UIImage()
            }
        } catch {
            print("History Imaage Error: \(error.localizedDescription)")
            return UIImage()
        }
    }
}
struct Rating: Codable {
    let movie: String
    let ratingNumber: Double
}
struct LimeResponse: Decodable {
    let lime_images: [LimeImage]
}
struct LimeImage: Identifiable, Decodable {
    var id: Int { self.index }
    let index: Int
    let image: String?
}
struct Top3Response: Codable {
    let movieRecommendation: [MovieRecommendation]
}
struct MovieRecommendation: Codable, Identifiable {
    var id: String { self.Title }
    let Title: String
    let predicted_rating: Double
}
struct CounterfactualResponse: Codable {
    let counterfactualExplanations: [CounterfactualText]
}
struct CounterfactualText: Codable, Identifiable {
    var id: String { self.title }
    let title: String
    let explanations: String
}
struct HistoryResponse: Codable {
    let historyValues: [HistoryValues]
}
struct HistoryValues: Codable, Identifiable {
    var id: String { self.name }
    let name: String
    let values: Double
}
struct LimeValuesResponse: Codable {
    let limeValues: [LimeValues]
}
struct LimeValues: Codable, Identifiable {
    var id: String { self.feature }
    var index: Int
    let feature: String
    let importance: Float
}
struct HistoryImageResponse: Decodable {
    let lossImage: String?
}
