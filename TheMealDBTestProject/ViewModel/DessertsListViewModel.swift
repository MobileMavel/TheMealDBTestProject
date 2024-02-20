//
//  MealsListViewModel.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import Foundation

class DessertsListViewModel: ObservableObject {
    @Published var deserts: [Deserts] = []
    
    func fetchDesertsList() async -> ResultType {
        let result = await DessertsService().getDesertsList()
        switch result {
            case .success(let mealsList):
                DispatchQueue.main.async {
                    self.deserts = mealsList.meals.sorted {$0.strMeal < $1.strMeal}
                }
                return .Success
            case .failure(let error):
                print(error)
                return .NoData
        }
    }
}
