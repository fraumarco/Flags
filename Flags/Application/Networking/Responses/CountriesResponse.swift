//
//  CountriesResponse.swift
//  Flags
//
//  Created by Marco Frau on 16/04/24.
//

import Foundation

typealias CountriesResponse = [CountryResponse]

struct CountryResponse: Codable {
    let name: CountryName?
}

struct CountryName: Codable {
    let common, official: String?
    let nativeName: CountryNativeName?
}

struct CountryNativeName: Codable {
    let ron: CountryRon?
}

struct CountryRon: Codable {
    let official, common: String?
}
