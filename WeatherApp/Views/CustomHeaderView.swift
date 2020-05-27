//
//  CustomHeaderView.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 14.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class CustomHeaderView: UIView {

    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.textColor = .white
        cityLabel.font = cityLabel.font.withSize(35.0)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    private let weatherConditionLabel: UILabel = {
        let weatherConditionLabel = UILabel()
        weatherConditionLabel.textColor = .white
        weatherConditionLabel.font = weatherConditionLabel.font.withSize(20.0)
        weatherConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherConditionLabel
    }()
    init(frame: CGRect, city: String, weatherCondition: String, temperature: String) {
        self.cityLabel.text = city
        self.weatherConditionLabel.text = weatherCondition
        super.init(frame: frame)
        setupHeaderView()
    }
    private func setupHeaderView() {
        addSubview(cityLabel)
        addSubview(weatherConditionLabel)
        isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherConditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50.0),
            weatherConditionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            weatherConditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
