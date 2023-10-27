//
//  AirportSearchModel.swift
//  AirPortSwiftUI
//
//  Created by Juan Jose Mendez Rojas on 26/10/23.
//

import Foundation

// MARK: - AirportSearchModelElement
struct AirportSearchModelElement: Codable {
    var iataCode, icaoCode, name, alpha2CountryCode: String?
    var latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case iataCode, icaoCode, name
        case alpha2CountryCode = "alpha2countryCode"
        case latitude, longitude
    }
}

typealias AirportSearchModel = [AirportSearchModelElement]
