//
//  File.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import Foundation

class DessertsService {
    func getDesertsList() async -> Result<DesertsListModel, ErrorType>  {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return .failure(.BadURL)
        }
        return await NetworkManager().fetchRequest(type: DesertsListModel.self, url: url)
    }
    func getDesertDetails(id: String) async -> Result<DessertDetailsList, ErrorType>  {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=" + id) else {
            return .failure(.BadURL)
        }
        return await NetworkManager().fetchRequest(type: DessertDetailsList.self, url: url)
    }
}
