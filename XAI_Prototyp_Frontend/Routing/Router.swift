//
//  Router.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 06.03.25.
//

import Foundation
import SwiftUI

//https://medium.com/@oguzoozer/swiftui-router-implementation-a-deep-dive-into-clean-architecture-navigation-690c06d8db05

final class Router: ObservableObject {
    
    public enum Destination: Hashable {
        case rating
        case result
        case explanation
        case ki 
        case help
        case licenses
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination : Destination){
        navPath.append(destination)
    }
    func goBack() {
        if !navPath.isEmpty {
            navPath.removeLast()
        }
    }
}
