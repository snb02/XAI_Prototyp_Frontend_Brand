//
//  OnboardingView.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 29.04.25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var router : Router
    @ObservedObject var viewModel : RatingMoviesViewModel
    @State private var textfieldText: String = ""
    @FocusState private var textfieldFocused: Bool
    
    struct Constants {
        static let roundedRectangleWidth: CGFloat = 350
        static let roundedRectangleHeight: CGFloat = 150
        static let roundedRectangleOffset: CGFloat = -100
        static let roundedRectangleCornerRadius: CGFloat = 150
        static let aiIconWidth: CGFloat = 70
        static let textFieldWidth: CGFloat = 270
        static let textFieldHeight: CGFloat = 50
        static let textFieldCornerRadius: CGFloat = 25
        static let radioButtonWidthHeight: CGFloat = 30
        static let innerRadioButtonWidthHeight: CGFloat = 22
        static let buttonWidth: CGFloat = 270
        static let buttonHeight: CGFloat = 50
        static let lineWidth: CGFloat = 2
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack(spacing: .paddingMedium) {
                Spacer()
                header()
                Spacer()
                nameTextField()
                Spacer()
                kiKnowledgeLevelCheckbox()
                Spacer()
                nextButton()
            }
            .padding(.horizontal, .paddingMedium)
            licenses()
        }
    }
    //https://www.flaticon.com/de/kostenloses-icon/ai_8131876?term=ai&related_id=8131876
    @ViewBuilder
    func header()-> some View {
        ZStack{
            HStack {
                RoundedRectangle(cornerRadius: Constants.roundedRectangleCornerRadius)
                    .frame(width: Constants.roundedRectangleWidth, height: Constants.roundedRectangleHeight)
                    .offset(x: Constants.roundedRectangleOffset)
                    .foregroundStyle(Color.lightBlue)
                Spacer()
            }
            HStack{
                Text("Prototyp BA - XAI \nSophie Brand\n(5194731)\nBei Thorsten Teschke")
                    .font(.medium)
                Image("ai")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.aiIconWidth)
                Spacer()
            }
        }
    }
    //https://developer.apple.com/forums/thread/738726
    @ViewBuilder
    func nameTextField()-> some View {
        VStack {
            Text("Hey, wie heißt du?")
                .font(Font.largeBold)
            TextField("NAME", text: $textfieldText)
                .focused($textfieldFocused)
                .onLongPressGesture(minimumDuration: 0.0) {
                    textfieldFocused = true
                }
                .autocorrectionDisabled()
                .multilineTextAlignment(.center)
                .frame(width: Constants.textFieldWidth, height: Constants.textFieldHeight)
                .background(
                    RoundedRectangle(cornerRadius: Constants.textFieldCornerRadius)
                        .stroke(Color.lightBlue, lineWidth: Constants.lineWidth)
                )
                .padding()
        }
    }
    @ViewBuilder
    func kiKnowledgeLevelCheckbox()-> some View {
        VStack(alignment: .leading, spacing: .paddingMedium) {
            Text("Hast du bereits Erfahrung mit Künstlicher Intelligenz (KI)?")
                .font(Font.largeBold)
                .padding(.bottom, .paddingSmall)
                .fixedSize(horizontal: false, vertical: true)
            HStack(spacing: .paddingSmall) {
                radioButton(detailgrad: .easy)
                Text("Ich hab wenig Ahnung von KI.")
                    .font(Font.medium)
            }
            HStack(spacing: .paddingSmall) {
                radioButton(detailgrad: .middle)
                Text("Ich habe KI-Grundkenntnisse.")
                    .font(Font.medium)
            }
            HStack(spacing: .paddingSmall) {
                radioButton(detailgrad: .hard)
                Text("Ich hab viel Ahnung von KI.")
                    .font(Font.medium)
            }
        }
        .padding(.vertical)
    }
    @ViewBuilder
    func radioButton(detailgrad: Detailgrad)-> some View {
        ZStack {
            Circle()
                .stroke(Color.lightBlue, lineWidth: Constants.lineWidth)
                .frame(width: Constants.radioButtonWidthHeight, height: Constants.radioButtonWidthHeight)
                .onTapGesture {
                    viewModel.detailgrad = detailgrad
                }
            Circle()
                .fill(Color.lightBlue)
                .opacity(viewModel.detailgrad == detailgrad ? 1.0 : 0)
                .frame(width: Constants.innerRadioButtonWidthHeight, height: Constants.innerRadioButtonWidthHeight)
        }
    }
    @ViewBuilder
    func nextButton()-> some View {
        let isInputComplete = textfieldText != ""

        Button(action: {
            if textfieldText != "" {
                viewModel.userName = textfieldText
                router.navigate(to: .rating)
            }
        }){
            Text("WEITER")
                .font(Font.largeBold)
                .foregroundStyle(Color.white)
                .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                .background(isInputComplete ? Color.lightBlue : Color.gray)
                .cornerRadius(.cornerRadiusBig)
        }
        .padding(.bottom, .paddingBig)
    }
    @ViewBuilder
    func licenses()-> some View {
        HStack {
            Button(action: {
                router.navigate(to: .licenses)
            }){
                Text("Lizenzen")
                    .font(Font.small)
                    .foregroundStyle(Color.gray)
            }
            .padding(.horizontal, .paddingMedium)
            Spacer()
        }
        .padding(.horizontal, .paddingBig)
        .offset(y: 30)
    }
}
