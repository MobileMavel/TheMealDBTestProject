//
//  ContentView.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import SwiftUI

struct DessertsListView: View {
    @StateObject var viewModel: DessertsListViewModel
    @State var result: ResultType = .Fetching
    var body: some View {
        NavigationStack {
            Group {
                switch result {
                    case .Success:
                        List(viewModel.deserts, id: \.idMeal) { dessert in
                            NavigationLink(destination: DesertDetailsView(viewModel: DessertDetailsViewModel(selectedID: dessert.idMeal))) {
                                DesertRowView(title: dessert.strMeal, imageURL: dessert.strMealThumb)
                            }
                        }
                        .listStyle(.plain)
                    case .NoData:
                        Image(systemName: "exclamationmark.triangle")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding(.bottom)
                        LabelView(
                            text: "Unable to fetch desserts!",
                            font: .title3)
                    case .Fetching:
                        ProgressView()
                }
            }
            .task {
                result = await viewModel.fetchDesertsList()
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
