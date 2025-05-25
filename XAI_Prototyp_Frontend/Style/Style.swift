//
//  Fonts.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 02.05.25.
//

import Foundation
import SwiftUI

extension Font {
    static let small = Font.custom("Helvetica", fixedSize: 15)
    static let medium = Font.custom("Helvetica", fixedSize: 17)
    static let large = Font.custom("Helvetica", fixedSize: 22)
    static let xLarge = Font.custom("Helvetica", fixedSize: 30)
    
    static let smallBold = Font.custom("Helvetica", fixedSize: 15).bold()
    static let mediumBold = Font.custom("Helvetica", fixedSize: 17).bold()
    static let largeBold = Font.custom("Helvetica", fixedSize: 22).bold()
    static let xLargeBold = Font.custom("Helvetica", fixedSize: 30).bold()
}


extension Color {
    static let lightBlue = Color(red: 0.694, green: 0.843, blue: 0.906)
    static let lightYellow = Color(red: 0.980, green: 0.980, blue: 0.694)
}

//https://stackoverflow.com/questions/34929932/round-up-double-to-2-decimal-places
//https://medium.com/@amrangry/rounding-numbers-in-swift-afb0de30ea85
extension Double {
    var oneDecimalNumbers: String {
        String(format: "%.1f", self)
    }
    var threeDecimalNumbers: String {
        String(format: "%.3f", self)
    }
    var roundToNextHalf: Double {
        return (self * 2).rounded() / 2
    }
}

extension CGFloat {
    static let paddingSmall = 10.0
    static let paddingMedium = 20.0
    static let paddingBig = 35.0
    static let cornerRadiusMini = 5.0
    static let cornerRadiusSmall = 10.0
    static let cornerRadiusMedium = 20.0
    static let cornerRadiusBig = 40.0
    static let lineSpacing = 10.0
    static let radius = 5.0
}
