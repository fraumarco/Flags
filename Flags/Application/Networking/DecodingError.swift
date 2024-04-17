//
//  DecodingError.swift
//  Flags
//
//  Created by Marco Frau on 17/04/24.
//

import Foundation

enum DecodingError: Equatable {
    case decodingFailure
}

extension DecodingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingFailure:
            return "An error occured when decoding the response"
        }
    }
}
