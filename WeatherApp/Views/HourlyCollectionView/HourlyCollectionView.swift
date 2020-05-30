//
//  HourlyCollectionView.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 14.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class HourlyCollectionView: UIView {
    private var collectionView: UICollectionView
    private var hourlyForecast: [Hourly]
    init(hourlyForecast: [Hourly]) {
        self.hourlyForecast = hourlyForecast
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        collectionView = UICollectionView(frame: CGRect(x: -1, y: 0,
                                                        width: UIScreen.main.bounds.width + 2,
                                                        height: 120),
                                          collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        super.init(frame: CGRect(x: 0.0, y: 0.0,
                                 width: UIScreen.main.bounds.width,
                                 height: 120.0))
        collectionView.register(HourlyForecastCollectionViewCell.self,
                                forCellWithReuseIdentifier:
            CellIdentifiers.hourlyWeatherCell.rawValue)
        addSubview(collectionView)
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = UIColor.lightText.cgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        isUserInteractionEnabled = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyForecast.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            CellIdentifiers.hourlyWeatherCell.rawValue, for: indexPath)
            as? HourlyForecastCollectionViewCell else { return UICollectionViewCell() }
        let currentForecast = hourlyForecast[indexPath.item]
        cell.weatherStateCode = currentForecast.weather.first?.icon
        if indexPath.item == 0 {
            cell.date = "Now"
            cell.dateLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
            cell.temperatureLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        } else {
            if let date = ConvertationMethods.shared.dateFrom(unixDate: currentForecast.dt) {
            cell.date = ConvertationMethods.shared.take(info: .hours, from: date)
            }
        }
        cell.temperature = "\(Int(currentForecast.temp))°"
        return cell
    }
}

extension HourlyCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 40.0, height: 100.0)
    }
}
