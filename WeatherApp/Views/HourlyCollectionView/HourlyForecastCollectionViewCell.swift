//
//  HourlyFirecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 14.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 20.0)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    let stateImageView: UIImageView = {
        let stateImageView = UIImageView()
        stateImageView.translatesAutoresizingMaskIntoConstraints = false
        return stateImageView
    }()
    let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont.systemFont(ofSize: 20.0)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    var weatherStateCode: String?
    var date: String?
    var temperature: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dateLabel)
        addSubview(stateImageView)
        addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            stateImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stateImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundColor = .clear
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        dateLabel.text = date
        stateImageView.image = UIImage(named: weatherStateCode ?? "")
        temperatureLabel.text = temperature
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
