//
//  HTTPError.swift
//  MyGymPartner
//
//  Created by Marco Frau on 29/03/24.
//

import Foundation

public enum HTTPError: Equatable {
    case statusCode(Int)
    case invalidResponse(Int)
    case notFoundResponse
}

public struct HttpStatusCode {
    public struct Informational {
        static let range = 100..<200
    }
    
    public struct Success {
        static let range = 200..<300
    }
    
    public struct Redirection {
        static let range = 300..<400
    }
    
    public struct ClientError {
        static let range = 400..<500
        static let badRequest = 400
        static let notFoundError = 401
    }
    
    public struct ServerError {
        static let range = 500..<600
    }
}


extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Error: 401", comment: "401")
        case .statusCode(let int):
            return String(int)
        case .notFoundResponse:
            return "Address not found"
        }
    }
}
