//
//  WeatherData.swift
//  Clima
//
//  Created by Richa Deshmukh on 4/22/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// Codable is a type alias that includes Decodable and Encodable
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
    let id: Int
}
