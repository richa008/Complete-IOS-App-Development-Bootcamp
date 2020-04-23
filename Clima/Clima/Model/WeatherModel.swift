//
//  WeatherModel.swift
//  Clima
//
//  Created by Richa Deshmukh on 4/22/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    // Stored properties
    let conditionId: Int
    let temperature: Double
    let cityName: String
    
    // Computed properties
    var temperatureString: String {
        return String(format: "%0.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
