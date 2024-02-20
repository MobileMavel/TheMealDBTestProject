//
//  MealDetailsView.swift
//  TheMealDBTestProject
//
//  Created by Dev on 18/02/2024.
//

import SwiftUI

struct DesertDetailsView: View {
    @StateObject var viewModel: DessertDetailsViewModel
    @State var result: ResultType = .Fetching
    var body: some View {
        Group {
            switch result {
                case .Success:
                    displayView
                    mealTitleAndDetails
                    ScrollView {
                        VStack(alignment: .leading) {
                            ingredientsAndMeasures
                            instructions
                        }
                    }
                    .padding(.horizontal)
                case .NoData:
                    Image(systemName: "exclamationmark.triangle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    LabelView(
                        text: "Unable to fetch dessert details!",
                        font: .title3)
                case .Fetching:
                    ProgressView()
            }
        }
        .task {
            result = await viewModel.fetchDesertDetails()
        }
        .toolbarBackground(
            Color.themeColor,
            for: .navigationBar
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    var instructions: some View {
        Group {
            LabelView(
                text: "Instructions",
                font: .title3,
                isBold: true
            )
            .padding(.bottom)
            LabelView(
                text: viewModel.desertDetails.strInstructions ?? "",
                font: .title2
            )
        }
    }
    
    var mealTitleAndDetails: some View {
        HStack {
            VStack(alignment: .leading) {
                LabelView(
                    text: viewModel.desertDetails.strMeal ?? "",
                    font: .largeTitle
                )
                LabelView(
                    text: viewModel.desertDetails.strArea ?? "",
                    font: .subheadline,
                    foregroundColor: .themeColor
                )
            }
            Spacer()
        }
        .padding(.all)
    }
    
    var ingredientsAndMeasures: some View {
        Group {
            LabelView(
                text: "Ingredients",
                font: .title3,
                isBold: true
            )
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
        }
        .padding(.bottom)
    }
    
    var displayView: some View {
        VStack {
            let displayTypeData = viewModel.getDisplayTypeURL()
            switch displayTypeData.type {
                case .video:
                    YouTubeView(videoId: displayTypeData.url)
                case .image:
                    AsyncImageView(url: displayTypeData.url)
                case .none:
                    EmptyView()
            }
        }
    }
}

struct DesertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DesertDetailsView(viewModel: DessertDetailsViewModel(selectedID: ""))
    }
}
