//
//  NetworkHandler.swift
//  MyGymPartner
//
//  Created by Marco Frau on 29/03/24.
//

import Foundation
import Combine

class NetworkHandler {
    
    static let shared: NetworkHandler = NetworkHandler()
    
    public func performRequest<T: Codable>(urlRequest: URLRequest, responseModel: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.invalidResponse(HttpStatusCode.ClientError.badRequest)
        }
                
        let statusCode = httpResponse.statusCode
        
        guard (HttpStatusCode.Success.range).contains(statusCode) else {
            if statusCode == HttpStatusCode.ClientError.notFoundError {
                throw HTTPError.notFoundResponse
            } else {
                throw HTTPError.invalidResponse(statusCode)
            }
        }
        
        let jsonDecoder = JSONDecoder()

        guard let decodedData: T = try? jsonDecoder.decode(T.self, from: data) else {
            throw DecodingError.decodingFailure
        }
        
        return decodedData
    }
    
}


