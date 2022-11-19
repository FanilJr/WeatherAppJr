//
//  DaysTableViewCell.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 10.11.2022.
//

import Foundation
import UIKit
import CoreLocation

protocol MyClassDelegateTwo: AnyObject {
    func tuchUp()
}

class ThreeDaysTableViewCell: UITableViewCell {
    
    var manager = WeatherDaysManager()
    var list: [List] = []
    let header = HeaderView()
    var search = UISearchController(searchResultsController: nil)
    
    weak var tuchNew: MyClassDelegateTwo?
    let locationManager = CLLocationManager()
    
    lazy var collectionViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        return collectionView
    }()
        
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Подробнее на 3 часа"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "thermometer.medium"), for: .normal)
        button.tintColor = UIColor(named: "weatherColor")
        button.layer.cornerRadius = 23 / 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tuch), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        daysWeatherList { list in
            DispatchQueue.main.async {
                self.list = list ?? []
                self.collectionViews.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tuch() {
        print("tuch по кнопке из TableViewCell")
        tuchNew?.tuchUp()
    }
    
    @objc private func tuchShare() {
        
    }
    
    private func layout() {
            
        [label, button, collectionViews].forEach { contentView.addSubview($0) }
                            
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 23),
            button.heightAnchor.constraint(equalToConstant: 23),
            button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
                
            collectionViews.topAnchor.constraint(equalTo: button.bottomAnchor,constant: 5),
            collectionViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collectionViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionViews.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

   

extension ThreeDaysTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        return list.count
            
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.setupCell(list[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        let recipe = list[indexPath.row]

        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let share = UIAction(title: "Share", image: UIImage(systemName:"square.and.arrow.up.circle")) { _ in
                print("Share")
                let avc = UIActivityViewController(activityItems: [recipe], applicationActivities: nil)
                print("В коллекции тап")
            }
            let menu = UIMenu(title: "", children: [share])
            return menu
        })
        return configuration
    }
}

extension ThreeDaysTableViewCell: UICollectionViewDelegateFlowLayout {
        
    private var interSpace: CGFloat { return 11 }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let width = (collectionView.bounds.width - interSpace * 3) / 4
        return CGSize(width: width, height: 75)
            
    }
}

extension ThreeDaysTableViewCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()

            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            self.manager.fetchWeather(latitude: lat, longitute: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
