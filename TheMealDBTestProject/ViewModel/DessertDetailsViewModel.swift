//
//  MeakDetailsViewModel.swift
//  TheMealDBTestProject
//
//  Created by Dev on 19/02/2024.
//

import Foundation

class DessertDetailsViewModel: ObservableObject {
    @Published var desertDetails = DessertDetails()
    @Published var ingredeientsDetails: [IngredientAndMeasure] = []
    private var selectedItemID: String
    
    enum displayType {
        case video
        case image
        case none
    }
    
    init(selectedID: String) {
        selectedItemID = selectedID
    }
    
    func fetchDesertDetails() async -> ResultType {
        let result = await DessertsService().getDesertDetails(id: selectedItemID)
        switch result {
            case .success(let mealDetails):
                DispatchQueue.main.async {
                    self.desertDetails = mealDetails.meals[0]
                    self.desertDetails.strYoutube = self.desertDetails.strYoutube?.replacingOccurrences(of: "watch?v=", with: "embed/")
                    self.ingredeientsDetails = self.desertDetails.ingredientsAndMeasures()
                }
                return .Success
            case .failure(let error):
                print(error)
                return .NoData
        }
    }
    
    func updateCheck(id: UUID) {
        if let index = ingredeientsDetails.firstIndex(where: { $0.id == id }) {
            ingredeientsDetails[index].selected.toggle()
        }
    }
    
    func getDisplayTypeURL() -> (url: String, type: displayType) {
        if let url = desertDetails.strYoutube, url != "" {
            return (url, .video)
        } else if let url = desertDetails.strMealThumb, url != ""{
            return (url, .image)
        }
        return ("", .none)
    }
}
