//
//  EndpointHandler.swift
//  MyGymPartner
//
//  Created by Marco Frau on 29/03/24.
//

import Foundation

enum Endpoints {
    case getCountries(String)
}

extension Endpoints {
    
    var path: String {
        switch self {
        case .getCountries:
            return "/v3.1/all"
        }
    }
    
    var method: String {
        switch self {
        case .getCountries:
            return "GET"
        }
    }
    
    var withQueryItems: Bool {
        switch self {
        case .getCountries:
            return true
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .getCountries(item):
            return [URLQueryItem(name: "flag", value: item)]
        }
    }
}

extension Endpoints {
    
    static private let basePath: String = "https://restcountries.com"
    
    var headers: [String:String] {
        return [:]
    }
    
    public func makeURL() -> URL {
        let urlString = Endpoints.basePath + path
        guard var url = URL(string: urlString) else {
            fatalError("Failed to create URL for endpoint: \(urlString)")
        }
        
        if self.withQueryItems, let queryItems = self.queryItems {
            url.append(queryItems: queryItems)
        }
        
        return url
    }
        
    public func makeURLRequest() -> URLRequest {
        var request = URLRequest(url: makeURL())
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
}
