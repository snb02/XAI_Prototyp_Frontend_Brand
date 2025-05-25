//
//  helpView.swift
//  MovieRecommendationWithXAIApp
//
//  Created by Sophie Brand on 30.04.25.
//

import SwiftUI

struct HelpView: View {
    @EnvironmentObject var router: Router
    @State var selectedStep = 0
    var viewModel : HelpViewModel
    
    struct Constants {
        static let imageWidth: CGFloat = 30
        static let iconHeight: CGFloat = 130
        static let stepCardHeight: CGFloat = 470
        static let singleStepWidth: CGFloat = 90
        static let singleStepHeight: CGFloat = 7
        static let buttonWidthHeight: CGFloat = 50
        static let oneStep: Int = 1
    }

    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toolbar-and-add-buttons-to-it
    var body: some View {
        VStack(spacing: .paddingSmall) {
            titleView()
            stepCard(title: viewModel.titles[selectedStep],
                     discription: viewModel.discriptions[selectedStep],
                     image: viewModel.images[selectedStep],
                     stichpoints: viewModel.stichpoints[selectedStep])
        }
        .padding(.horizontal, .paddingMedium)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    router.goBack()
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.black)
                }
            }
        }
    }
    @ViewBuilder
    func titleView()-> some View {
        HStack{
            Text("WAS ZEIGEN DIR DIE ERKLÄRUNGEN?")
                .multilineTextAlignment(.center)
                .font(.largeBold)
            Image("lightBulb")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.imageWidth)
        }
    }
    @ViewBuilder
    func stepCard(title: String, discription: String, image: String, stichpoints: String) -> some View{
        VStack(spacing: .paddingSmall) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: Constants.iconHeight)
                .padding(.vertical, .paddingSmall)
            stepIndicator()
            ZStack(alignment: .bottom) {
                detailText(title: title, discription: discription, stichpoints: stichpoints)
                    .padding(.horizontal, .paddingMedium)
                    .padding(.top, .paddingMedium)
                nextStepButton()
            }
            .frame(maxWidth: .infinity)
            .frame(height: Constants.stepCardHeight)
            .background(Color.lightBlue)
            .cornerRadius(.cornerRadiusMedium)
            .padding(.horizontal, .paddingSmall)
        }
    }
    @ViewBuilder
    func detailText(title: String, discription: String, stichpoints: String) -> some View{
        ScrollView(){
            VStack(alignment: .leading, spacing: .paddingSmall){
                Text(title)
                    .font(Font.largeBold)
                Text(discription)
                    .font(Font.medium)
                    .padding(.bottom, .paddingSmall)
                Text(stichpoints)
                    .padding(.bottom, .paddingSmall)
                Spacer()
            }
            .lineSpacing(.lineSpacing)
        }
    }
    @ViewBuilder
    func stepIndicator()-> some View {
        HStack(spacing: .paddingSmall) {
            Group {
                Rectangle()
                    .foregroundColor(selectedStep == 0 ? .lightBlue : .gray)
                Rectangle()
                    .foregroundColor(selectedStep == 1 ? .lightBlue : .gray)
                Rectangle()
                    .foregroundColor(selectedStep == 2 ? .lightBlue : .gray)
            }
            .frame(width: Constants.singleStepWidth, height: Constants.singleStepHeight)
            .cornerRadius(.cornerRadiusMini)
        }
    }
    @ViewBuilder
    func nextStepButton()-> some View {
        HStack {
            Button(action:{
                if selectedStep >= Constants.oneStep {
                    selectedStep -= Constants.oneStep
                }
            }){
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .bold()
            }
            .frame(width: Constants.buttonWidthHeight, height: Constants.buttonWidthHeight)
            .background(Color.white)
            .cornerRadius(.cornerRadiusSmall)
            .offset(x: -.paddingSmall)
            Spacer()
            Button(action:{
                if selectedStep <= Constants.oneStep {
                    selectedStep += Constants.oneStep
                }
            }){
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                    .bold()
            }
            .frame(width: Constants.buttonWidthHeight, height: Constants.buttonWidthHeight)
            .background(Color.white)
            .cornerRadius(.cornerRadiusSmall)
            .offset(x: .paddingSmall)
        }
        .padding(.bottom, .paddingMedium)
    }
}
