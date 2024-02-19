//
//  MealDetailsModel.swift
//  TheMealDBTestProject
//
//  Created by Dev on 18/02/2024.
//

import Foundation

struct DessertDetailsList: Codable {
    let meals: [DessertDetails]
}

struct DessertDetails: Codable {
    var idMeal: String? = nil
    var strMeal: String? = nil
    var strDrinkAlternate: String? = nil
    var strCategory: String? = nil
    var strArea: String? = nil
    var strInstructions: String? = nil
    var strMealThumb: String? = nil
    var strTags: String? = nil
    var strYoutube: String? = nil
    var strIngredient1: String? = nil
    var strIngredient2: String? = nil
    var strIngredient3: String? = nil
    var strIngredient4: String? = nil
    var strIngredient5: String? = nil
    var strIngredient6: String? = nil
    var strIngredient7: String? = nil
    var strIngredient8: String? = nil
    var strIngredient9: String? = nil
    var strIngredient10: String? = nil
    var strIngredient11: String? = nil
    var strIngredient12: String? = nil
    var strIngredient13: String? = nil
    var strIngredient14: String? = nil
    var strIngredient15: String? = nil
    var strIngredient16: String? = nil
    var strIngredient17: String? = nil
    var strIngredient18: String? = nil
    var strIngredient19: String? = nil
    var strIngredient20: String? = nil
    var strMeasure1: String? = nil
    var strMeasure2: String? = nil
    var strMeasure3: String? = nil
    var strMeasure4: String? = nil
    var strMeasure5: String? = nil
    var strMeasure6: String? = nil
    var strMeasure7: String? = nil
    var strMeasure8: String? = nil
    var strMeasure9: String? = nil
    var strMeasure10: String? = nil
    var strMeasure11: String? = nil
    var strMeasure12: String? = nil
    var strMeasure13: String? = nil
    var strMeasure14: String? = nil
    var strMeasure15: String? = nil
    var strMeasure16: String? = nil
    var strMeasure17: String? = nil
    var strMeasure18: String? = nil
    var strMeasure19: String? = nil
    var strMeasure20: String? = nil
    var strSource: String? = nil
    var strImageSource: String? = nil
    var strCreativeCommonsConfirmed: String? = nil
    var dateModified: String? = nil
    
    func ingredientsAndMeasures() -> [IngredientAndMeasure] {
        var result: [(String, String, Bool)] = []
        let mirror = Mirror(reflecting: self)
        var array = [IngredientAndMeasure]()
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            if let ingredient = mirror.descendant(ingredientKey) as? String,
               let measure = mirror.descendant(measureKey) as? String,
               !ingredient.isEmpty && !measure.isEmpty {
                result.append((ingredient, measure, false))
                array.append(IngredientAndMeasure(ingredientName: ingredient, ingredientMeasure: measure, selected: false))
            }
        }
        return array
    }
}

struct IngredientAndMeasure: Hashable, Identifiable {
    var ingredientName: String
    var ingredientMeasure: String
    var selected: Bool
    var id = UUID()
    
    init(ingredientName: String, ingredientMeasure: String, selected: Bool) {
        self.ingredientName = ingredientName
        self.ingredientMeasure = ingredientMeasure
        self.selected = selected
    }
}
