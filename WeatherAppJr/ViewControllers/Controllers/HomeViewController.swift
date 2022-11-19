//
//  HomeViewController.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 05.11.2022.
//

import UIKit
import CoreLocation

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    

    var header = HeaderView()
    var weatherManager = WeatherManager()
    var list: [List] = []
    var threeDays = ThreeDaysTableViewCell()
    var weatherDaysManager = WeatherDaysManager()
    let locationManager = CLLocationManager()
    weak var delegate: HomeViewControllerDelegate?
    
    private let background: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(ThreeDaysTableViewCell.self, forCellReuseIdentifier: "ThreeDaysTableViewCell")
        table.register(AllDaysTableViewCell.self, forCellReuseIdentifier: "AllDaysTableViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        tableView.delegate = self
        tableView.dataSource = self
        layout()

        view.backgroundColor = .systemBackground
        title = "Главная"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
    }
    
    func layout() {
        view.addSubview(background)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: background.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 10),
            tableView.trailingAnchor.constraint(equalTo: background.trailingAnchor,constant: -10),
            tableView.bottomAnchor.constraint(equalTo: background.bottomAnchor,constant: -10)
        ])
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}


extension HomeViewController: CLLocationManagerDelegate {
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

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return header
        case 1:
            return nil
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Ежедневная погода"
        default:
            return nil
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeDaysTableViewCell", for: indexPath) as! ThreeDaysTableViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllDaysTableViewCell", for: indexPath) as! AllDaysTableViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}


