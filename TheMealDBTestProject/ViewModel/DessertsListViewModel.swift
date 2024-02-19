//
//  MealsListViewModel.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import Foundation

class DessertsListViewModel: ObservableObject {
    @Published var mealsList: [Deserts] = []
    @Published var isErrorPresent: Bool = false
    func fetchMealsList() async {
        let result = await DessertsService().getDesertsList()
        switch result {
            case .success(let mealsList):
                DispatchQueue.main.async {
                    self.mealsList = mealsList.meals
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.isErrorPresent = true
                }
        }
    }
}
