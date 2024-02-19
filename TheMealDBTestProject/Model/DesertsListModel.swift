//
//  MealsListModel.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import Foundation

struct DesertsListModel: Codable {
    let meals: [Deserts]
}

struct Deserts: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
