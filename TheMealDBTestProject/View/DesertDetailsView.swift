//
//  MealDetailsView.swift
//  TheMealDBTestProject
//
//  Created by Dev on 18/02/2024.
//

import SwiftUI

struct DesertDetailsView: View {
    @StateObject var viewModel: DessertDetailsViewModel
    @State private var isPlayingVideo = false
    @State private var isVideoAvailable = true
    var body: some View {
        GeometryReader { geo in
            VStack {
                if viewModel.isErrorPresent {
                    Image(systemName: "exclamationmark.triangle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    LabelView(
                        text: "Unable to fetch dessert details!",
                        font: .title3)
                } else if viewModel.mealDetails.idMeal == nil {
                    ProgressView()
                } else {
                    youtubeView(url: viewModel.mealDetails.strYoutube ?? "", size: geo.size)
                    HStack {
                        VStack(alignment: .leading) {
                            mealTitleAndDetails
                            ScrollView {
                                ingredientsAndMeasures
                                instructions
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.all)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMealDetails()
                }
            }
        }
        .toolbarBackground(
            Color.themeColor,
            for: .navigationBar
        )
        .foregroundColor(.black)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    var instructions: some View {
        VStack(alignment: .leading) {
            LabelView(
                text: "Instructions",
                font: .title3,
                isBold: true
            )
            .padding(.bottom)
            LabelView(
                text: viewModel.mealDetails.strInstructions ?? "",
                font: .title2
            )
        }
    }
    
    var mealTitleAndDetails: some View {
        VStack(alignment: .leading) {
            LabelView(
                text: viewModel.mealDetails.strMeal ?? "",
                font: .largeTitle
            )
            LabelView(
                text: viewModel.mealDetails.strArea ?? "",
                font: .subheadline,
                foregroundColor: .themeColor
            )
            .padding(.bottom)
        }
    }
    
    var ingredientsAndMeasures: some View {
        VStack(alignment: .leading) {
            LabelView(
                text: "Ingredients",
                font: .title3,
                isBold: true
            )
            .padding(.bottom)
            ForEach(viewModel.ingredeientsDetails, id: \.id) { details in
                HStack {
                    Image(systemName: details.selected ? "checkmark.circle.fill" : "circle")
                        .imageScale(.small)
                        .foregroundColor(Color.black)
                    LabelView(
                        text: details.ingredientName.description.capitalized,
                        font: .title3
                    )
                    Spacer()
                    LabelView(
                        text: details.ingredientMeasure,
                        font: .title3
                    )
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.updateCheck(id: details.id)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.bottom)
    }
    
    func youtubeView(url: String, size: CGSize) -> some View {
        VStack {
            YouTubeView(videoId: viewModel.mealDetails.strYoutube ?? "")
        }
        .frame(width: size.width, height: size.height * 0.48)
    }
}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DesertDetailsView(viewModel: DessertDetailsViewModel(selectedID: ""))
    }
}
