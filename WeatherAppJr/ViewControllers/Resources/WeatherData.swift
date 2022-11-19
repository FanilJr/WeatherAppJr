//
//  WeatherData.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 08.11.2022.
//

import Foundation

// MARK: DAY
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let coord: Coordinates
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let temp_max: Double
    let temp_min: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

// MARK: DAYS
struct Answer: Decodable {
    let cod: String?
    let message: Int?
    let cnt: Int?
    let list: [List]
}

struct List: Codable {
    let main: MainSecond
    let weather: [WeatherSecond]
    let wind: WindSecond
    let dt_txt: String
}

struct WeatherSecond: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WindSecond: Codable {
    let gust: Double
    let speed: Double
    let deg: Int
}

struct MainSecond: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let temp_max: Double
    let temp_min: Double
    let temp_kf: Double
}



