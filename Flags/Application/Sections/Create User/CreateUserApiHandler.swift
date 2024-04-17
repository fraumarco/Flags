//
//  CreateUserApiHandler.swift
//  Flags
//
//  Created by Marco Frau on 17/04/24.
//

import Foundation
import Combine

class CreateUserApiHandler {
    
    private init() {}
    
    static let shared = CreateUserApiHandler()
    
    func getCountries() async throws -> CountriesResponse? {
        
        var countries: CountriesResponse? = nil
        
        do {
            countries = try await NetworkHandler.shared.performRequest(urlRequest: Endpoints.getCountries("name").makeURLRequest(), responseModel: CountriesResponse.self)
        } catch {
            print("Api failure")
        }
        
        return countries
    }
    
}
