//
//  CustomCollectionViewCell.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 10.11.2022.
//

import Foundation
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var list = [List]()
    
    var blure: UIVisualEffectView = {
        let bluereEffect = UIBlurEffect(style: .light)
        let blure = UIVisualEffectView()
        blure.effect = bluereEffect
        blure.translatesAutoresizingMaskIntoConstraints = false
        return blure
    }()
    
    var temp: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = .systemFont(ofSize: 15, weight: .heavy)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    var timeWeather: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = .systemFont(ofSize: 15, weight: .light)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    var dayWeather: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = .systemFont(ofSize: 11, weight: .light)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    var imageWeather: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "weatherColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 2
        self.layer.shadowRadius = 30
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        
        setupCell()
        removeCharacter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupCell(_ model: List) {
        temp.text = "\(Int(model.main.temp))" + "°" + "C"
        timeWeather.text = "\(model.dt_txt)"
        dayWeather.text = "\(model.dt_txt)"
        
        removeCharacter()
    }

    
    func removeCharacter() {
        timeWeather.text?.removeFirst(10)
        timeWeather.text?.removeLast(3)
        dayWeather.text?.removeLast(8)
    }
    


    private func setupCell() {
        
        [blure, temp, timeWeather, dayWeather].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            blure.topAnchor.constraint(equalTo: topAnchor),
            blure.leadingAnchor.constraint(equalTo: leadingAnchor),
            blure.trailingAnchor.constraint(equalTo: trailingAnchor),
            blure.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            timeWeather.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeWeather.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -25),
            
            temp.centerXAnchor.constraint(equalTo: centerXAnchor),
            temp.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dayWeather.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayWeather.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 25)
        ])
    }    
}


