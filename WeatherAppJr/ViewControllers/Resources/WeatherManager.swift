//
//  JSONWeather.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 07.11.2022.
//

import CoreLocation
import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

protocol WeatherDaysManagerDelegate {
    func didUpdateDaysWeather(_ weatherManager: WeatherDaysManager, weather: WeatherDaysModel)
    func didFailWithDaysError(error: Error)
}
// MARK: NOW
struct WeatherManager {
    
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?&lang=ru&appid=c8edff43d2a26500ee2d70c5db1712e9&units=metric"

    var delegate: WeatherManagerDelegate?

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)".encodeURL
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let feelsLike = decodedData.main.feels_like
            let humidity = decodedData.main.humidity
            let speed = decodedData.wind.speed
            let name = decodedData.name
            let description = decodedData.weather[0].description

            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, feelsLike: feelsLike, humidity: humidity, speed: speed, description: description)

            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

struct WeatherDaysManager {
    let daysWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?&lang=ru&appid=c8edff43d2a26500ee2d70c5db1712e9&units=metric"

    var delegate: WeatherDaysManagerDelegate?

    func fetchWeather(cityName: String) {
        let urlString = "\(daysWeatherURL)&q=\(cityName)".encodeURL
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(daysWeatherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithDaysError(error: error!)
                    return
                }

                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateDaysWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ weatherData: Data) -> WeatherDaysModel? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(Answer.self, from: weatherData)
            let list = decodedData.list
            let temp = decodedData.list[0].main.temp
            let time = decodedData.list[0].dt_txt
            let day = decodedData.list[0].dt_txt
            let weatherDays = WeatherDaysModel(list: list, temp: temp, time: time, day: day)

            return weatherDays
        } catch {
            delegate?.didFailWithDaysError(error: error)
            return nil
        }
    }
}
//
//func daysWeather(completion: ((_ item: [List]?) -> Void)?) {
//    let session = URLSession(configuration: .default)
//    let task = session.dataTask(with: URL(string: "https://api.openweathermap.org/data/2.5/forecast?&lang=ru&appid=c8edff43d2a26500ee2d70c5db1712e9&units=metric&q=Ekaterinburg")!) { data, responce, error in
//        if let error {
//            print(error.localizedDescription)
//            completion?(nil)
//            return
//        }
//        if (responce as? HTTPURLResponse)?.statusCode != 200 {
//            print("statusCode = \((responce as? HTTPURLResponse)?.statusCode)")
//            return
//        }
//
//        guard let data else {
//            print("data = nil")
//            return
//        }
//
//        do {
//            let answer = try JSONDecoder().decode(Answer.self, from: data)
//            completion?(answer.list)
//        } catch {
//            print(error)
//            completion?(nil)
//        }
//    }
//    task.resume()
//}
//
func daysWeatherList(searchString: String? = nil, completion: ((_ list: [List]?) -> Void)?) {

//    api.openweathermap.org/data/2.5/forecast/daily?q=München,DE&appid=c8edff43d2a26500ee2d70c5db1712e9
    var urlString = "https://api.openweathermap.org/data/2.5/forecast?&lang=ru&appid=c8edff43d2a26500ee2d70c5db1712e9&units=metric&q=Ekaterinburg"

    if let searchString = searchString, searchString != "" {
        urlString =
        "https://api.openweathermap.org/data/2.5/forecast?&lang=ru&appid=c8edff43d2a26500ee2d70c5db1712e9&units=metric&q=\(searchString)".encodeURL
    }

    downloadData(url: URL(string: urlString)!) {
        data in
        guard let data else { return }

        do {
            let answer = try JSONDecoder().decode(Answer.self, from: data)
            completion?(answer.list)
        } catch {
            print(error)
            print("сюда заходим")
            completion?(nil)
        }
    }
}

func downloadData(url: URL, completion: ((_ data: Data?) -> Void)?) {
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) {
        data, responce, error in

        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }

        if (responce as? HTTPURLResponse)?.statusCode != 200 {
            print("StatusCode = \((responce as? HTTPURLResponse)?.statusCode)")
            return
        }

        guard let data else {
            print("Data = nil")
            return
        }
        completion?(data)
    }
    task.resume()
}
