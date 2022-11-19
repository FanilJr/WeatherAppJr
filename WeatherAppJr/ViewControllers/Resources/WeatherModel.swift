//
//  WeatherModel.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 08.11.2022.
//

import Foundation

struct WeatherDaysModel {
    let list: [List]
    let temp: Double
    let time: String
    let day: String
}

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let speed: Double
    let description: String

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
        case 801...804:
            return "cloud.rain"
        default:
            return "cloud"
        }
    }
}
