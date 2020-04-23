//
//  WeatherManager.swift
//  Clima
//
//  Created by Richa Deshmukh on 4/20/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?appid=375c168a771a56fae544bd38a1481708&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherData(cityName: String) {
        let urlString = "\(apiUrl)&q=\(cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(apiUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    // with is external parameter name, urlString ix internal parameter name
    func performRequest(with urlString: String) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            // Create a session
            let session = URLSession(configuration: .default)
            
            // Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if (error != nil) {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let model = self.parseJson(safeData) {
                        // Have to use self since this is inside a closure
                        // ? is optional chaining
                        self.delegate?.didUpdateWeather(weather: model)
                    }
                }
            }
            
            // start task
            task.resume()
            
        }
    }
    
    func parseJson(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let temperature = decodedData.main.temp
            let city = decodedData.name
            let id = decodedData.weather[0].id
            
            let model = WeatherModel(conditionId: id, temperature: temperature, cityName: city)
            return model
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
