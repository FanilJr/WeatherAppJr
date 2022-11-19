//
//  InfoViewController.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 05.11.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private let background: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    let contentView: UIView = {
        let content = UIView()
        content.backgroundColor = .clear
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    let labelView: UILabel = {
        let label = UILabel()
        label.text = "Важно!"
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = #"""
            Что не работает:\#n
            1. Погода с расстоянием в 5 дней - выгружается только для города "Екатеринбург".\#n
            2. Не доделана ячейка погоды с расстоянием в: "1 час"\#n
            3. Констрейнты - не доделаны.\#n
            4. AppRating - в процессе.\#n
            5. ShareApp - в процессе.\#n
            6. Настройки - в процессе
            """#
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setup()
    }
    
    
    
    func setup() {
        
        [background,scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(contentView)
        [labelView, infoLabel].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: background.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: background.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: background.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: background.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            labelView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 22),
            labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            infoLabel.topAnchor.constraint(equalTo: labelView.bottomAnchor,constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ])
    }
}
