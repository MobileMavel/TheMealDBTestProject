//
//  MealsListModel.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import Foundation

enum ResultType: Error {
    case Success
    case NoData
    case Fetching
}

struct DesertsListModel: Codable {
    let meals: [Deserts]
}

struct Deserts: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
