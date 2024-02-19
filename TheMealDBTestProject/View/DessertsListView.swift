//
//  ContentView.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import SwiftUI

struct DessertsListView: View {
    @StateObject var viewModel: DessertsListViewModel
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isErrorPresent {
                    Image(systemName: "exclamationmark.triangle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    LabelView(
                        text: "Unable to fetch desserts!",
                        font: .title3)
                } else if viewModel.mealsList.isEmpty {
                    ProgressView()
                } else {
                    List(viewModel.mealsList.sorted(by: { lhs, rhs in lhs.strMeal < rhs.strMeal}), id: \.idMeal) { dessert in
                        NavigationLink(destination: DesertDetailsView(viewModel: DessertDetailsViewModel(selectedID: dessert.idMeal))) {
                            DesertRowView(title: dessert.strMeal, imageURL: dessert.strMealThumb)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMealsList()
                }
            }
            .navigationTitle("Desserts")
            .toolbarBackground(
                Color.themeColor,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct DessertsListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertsListView(viewModel: DessertsListViewModel())
    }
}
