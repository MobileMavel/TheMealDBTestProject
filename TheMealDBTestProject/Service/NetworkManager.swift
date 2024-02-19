//
//  NetworkManager.swift
//  TheMealDBTestProject
//
//  Created by Dev on 17/02/2024.
//

import Foundation

enum ErrorType: Error {
    case BadURL
    case NoData
    case DecodingError
}

class NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL) async -> Result<T, ErrorType> {
        let aPIResult = await aPIHandler.fetchData(url: url)
        switch aPIResult {
            case .success(let data):
                let responseResult = await responseHandler.fetchModel(type: type, data: data)
                switch responseResult {
                    case .success(let model):
                        return .success(model)
                    case .failure(let error):
                        return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
        }
    }
}

protocol APIHandlerDelegate {
    func fetchData(url: URL) async -> Result<Data, ErrorType>
}

class APIHandler: APIHandlerDelegate {
    func fetchData(url: URL) async -> Result<Data, ErrorType> {
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    continuation.resume(returning: .failure(.NoData))
                    return
                }
                continuation.resume(returning: .success(data))
            }.resume()
        }
    }
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async -> Result<T, ErrorType>
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async -> Result<T, ErrorType> {
        if let response = try? JSONDecoder().decode(type.self, from: data) {
            return .success(response)
        } else {
            return .failure(.DecodingError)
        }
    }
}
