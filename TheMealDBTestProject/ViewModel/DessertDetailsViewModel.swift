//
//  MeakDetailsViewModel.swift
//  TheMealDBTestProject
//
//  Created by Dev on 19/02/2024.
//

import Foundation

class DessertDetailsViewModel: ObservableObject {
    @Published var mealDetails = DessertDetails()
    @Published var ingredeientsDetails: [IngredientAndMeasure] = []
    private var selectedItemID: String
    @Published var isErrorPresent: Bool = false
    
    init(selectedID: String) {
        selectedItemID = selectedID
    }
    
    func fetchMealDetails() async {
        let result = await DessertsService().getDesertDetails(id: selectedItemID)
        switch result {
            case .success(let mealDetails):
                DispatchQueue.main.async {
                    self.mealDetails = mealDetails.meals[0]
                    self.ingredeientsDetails = self.mealDetails.ingredientsAndMeasures()
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.isErrorPresent = true
                }
        }
    }
    
    func updateCheck(id: UUID) {
        if let index = ingredeientsDetails.firstIndex(where: { $0.id == id }) {
            ingredeientsDetails[index].selected.toggle()
        }
    }
}
