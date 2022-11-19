//
//  HeaderView.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 07.11.2022.
//

import UIKit
import CoreLocation

class HeaderView: UIView {
    
    var weatherManager = WeatherManager()
    var weatherDaysManager = WeatherDaysManager()
    var list: [List] = []
    
    let locationManager = CLLocationManager()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)
        button.tintColor = UIColor(named: "weatherColor")
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        return button
    }()
        
    let searchTextField: CustomTextField = {
        let statusTextField = CustomTextField(placeholder: "Введите название города", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        statusTextField.tintColor = UIColor(named: "#4885CC")
        statusTextField.textColor = UIColor(named: "weatherColor")
        statusTextField.keyboardType = .webSearch
        return statusTextField
    }()
        
    var imageWeather: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "weatherColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imageWeatherSmall: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "colorMode")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let descriptionLabel: UILabel = {
       let fullNameLabel = UILabel()
       fullNameLabel.font = .systemFont(ofSize: 15, weight: .light)
       fullNameLabel.textColor = UIColor(named: "colorMode")
       fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
       return fullNameLabel
   }()
    
    let speed: UILabel = {
       let fullNameLabel = UILabel()
       fullNameLabel.font = .systemFont(ofSize: 15, weight: .light)
        fullNameLabel.textColor = UIColor(named: "colorMode")
       fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
       return fullNameLabel
   }()
    
    let humidity: UILabel = {
       let fullNameLabel = UILabel()
       fullNameLabel.font = .systemFont(ofSize: 15, weight: .light)
        fullNameLabel.textColor = UIColor(named: "colorMode")
       fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
       return fullNameLabel
   }()
    
    let feelsLike: UILabel = {
       let fullNameLabel = UILabel()
       fullNameLabel.font = .systemFont(ofSize: 15, weight: .light)
        fullNameLabel.textColor = UIColor(named: "colorMode")
       fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
       return fullNameLabel
   }()
        
     let tempCity: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = .systemFont(ofSize: 80, weight: .heavy)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    let tempCityGradus: UILabel = {
       let fullNameLabel = UILabel()
        fullNameLabel.font = .systemFont(ofSize: 80, weight: .ultraLight)
       fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
       return fullNameLabel
   }()

    
     let nameCity: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.numberOfLines = 0
        fullNameLabel.font = .systemFont(ofSize: 50, weight: .heavy)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    private let spinnerButton: UIActivityIndicatorView = {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    private let spinnerTemp: UIActivityIndicatorView = {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        searchTextField.setupLeftView(imageViewNamed: "magnifyingglass.circle.fill")
        
        layout()
        searchTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        waitingSpinnerEnableTemp(true)
//        weatherDaysManager.delegate = self
        searchTextField.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func waitingSpinnerEnable(_ active: Bool) {
        if active {
            spinnerButton.startAnimating()
        } else {
            spinnerButton.stopAnimating()
        }
    }
    
    func waitingSpinnerEnableTemp(_ active: Bool) {
        if active {
            spinnerTemp.startAnimating()
        } else {
            spinnerTemp.stopAnimating()
        }
    }
    
    @objc func locationPressed() {
        locationManager.requestLocation()
        button.setBackgroundImage(UIImage(named: "nil"), for: .normal)
        waitingSpinnerEnable(true)
    }
    
    func layout() {
        [button, spinnerButton, searchTextField, imageWeather, tempCity, spinnerTemp, tempCityGradus,nameCity, descriptionLabel, imageWeatherSmall,speed, humidity, feelsLike].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            spinnerButton.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            spinnerButton.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: button.leadingAnchor,constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            imageWeather.topAnchor.constraint(equalTo: searchTextField.bottomAnchor,constant: 10),
            imageWeather.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageWeather.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageWeather.heightAnchor.constraint(equalToConstant: 100),
            
            tempCity.topAnchor.constraint(equalTo: imageWeather.bottomAnchor,constant: 10),
            tempCity.centerXAnchor.constraint(equalTo: imageWeather.centerXAnchor),
            tempCity.heightAnchor.constraint(equalToConstant: 80),
            
            spinnerTemp.centerXAnchor.constraint(equalTo: tempCity.centerXAnchor),
            spinnerTemp.centerYAnchor.constraint(equalTo: tempCity.centerYAnchor),
            
            tempCityGradus.centerYAnchor.constraint(equalTo: tempCity.centerYAnchor),
            tempCityGradus.leadingAnchor.constraint(equalTo: tempCity.trailingAnchor),
            
            nameCity.topAnchor.constraint(equalTo: tempCity.bottomAnchor),
            nameCity.centerXAnchor.constraint(equalTo: imageWeather.centerXAnchor),
            nameCity.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameCity.bottomAnchor,constant: 30),
            descriptionLabel.centerXAnchor.constraint(equalTo: imageWeather.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            imageWeatherSmall.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            imageWeatherSmall.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor,constant: 5),
            imageWeatherSmall.widthAnchor.constraint(equalToConstant: 10),
            imageWeatherSmall.heightAnchor.constraint(equalToConstant: 10),
            
            humidity.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            humidity.centerXAnchor.constraint(equalTo: imageWeather.centerXAnchor),
            humidity.heightAnchor.constraint(equalToConstant: 20),
            
            feelsLike.topAnchor.constraint(equalTo: humidity.bottomAnchor),
            feelsLike.centerXAnchor.constraint(equalTo: imageWeather.centerXAnchor),
            feelsLike.heightAnchor.constraint(equalToConstant: 20),
            
            speed.topAnchor.constraint(equalTo: feelsLike.bottomAnchor),
            speed.centerXAnchor.constraint(equalTo: imageWeather.centerXAnchor),
            speed.heightAnchor.constraint(equalToConstant: 20),
            speed.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension HeaderView: UITextFieldDelegate {

    @objc func searchPressed() {
        searchTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        waitingSpinnerEnableTemp(true)
        
        tempCity.text = ""
        tempCityGradus.text = ""
        nameCity.text = ""
        imageWeather.image = UIImage()
        imageWeatherSmall.image = UIImage()
        speed.text = ""
        humidity.text = ""
        feelsLike.text = ""
        descriptionLabel.text = ""
    return true
}

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Введите название города."
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text?.replacingOccurrences(of: " ", with: "") {
            if city == "хуй" {
                DispatchQueue.main.async {
                    self.tempCity.text = "далбаёп"
                    self.waitingSpinnerEnableTemp(false)
                }
            }
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension HeaderView: WeatherManagerDelegate {
func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    
    DispatchQueue.main.async { [self] in
        tempCity.text = "\(Int(weather.temperature))"
        nameCity.text = weather.cityName
        imageWeather.image = UIImage(systemName: weather.conditionName)
        speed.text = "Скорость ветра \(Int(weather.speed))м/с"
        humidity.text = "Влажность \(weather.humidity)%"
        feelsLike.text = "Ощущается как \(Int(weather.feelsLike))" + "°" + "C"
        descriptionLabel.text = weather.description
        imageWeatherSmall.image = UIImage(systemName: weather.conditionName)
        tempCityGradus.text = "°"
        waitingSpinnerEnable(false)
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        self.waitingSpinnerEnableTemp(false)
    }
}

func didFailWithError(error: Error) {
    DispatchQueue.main.async {
        self.tempCity.text = "Такого"
        self.nameCity.text = "города нет ;("
        self.waitingSpinnerEnableTemp(false)
        
        }
    }
}

extension HeaderView: WeatherDaysManagerDelegate {
    func didUpdateDaysWeather(_ weatherManager: WeatherDaysManager, weather: WeatherDaysModel) {
            print("Holla")
        }


    func didFailWithDaysError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension HeaderView: CLLocationManagerDelegate {
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
        
        locationManager.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        weatherManager.fetchWeather(latitude: lat, longitute: lon)
    }
}

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension UITextField {
    
    func setupLeftView(imageViewNamed: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.backgroundColor = UIColor(named: "weatherColor")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: imageViewNamed)
        let imageViewContrainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContrainerView.addSubview(imageView)
        leftView = imageViewContrainerView
        leftViewMode = .always
    }
}


