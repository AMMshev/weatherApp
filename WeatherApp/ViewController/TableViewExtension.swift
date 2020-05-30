//
//  TableViewExtension.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 15.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

extension ViewController {
    enum SectionType {
        case temperatureSection
        case fullInfoSection
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func checkSavedData() {
        if weatherInfo == nil {
            tableViewNotsetted = true
        } else {
            setupTableView()
            tableViewNotsetted = false
        }
    }
    func setupTableView() {
        DispatchQueue.main.async {
            self.setupHeader()
            self.view.addSubview(self.tableView)
            NSLayoutConstraint.activate([
                self.tableView.topAnchor.constraint(equalTo: self.headerView?.bottomAnchor ?? self.view.topAnchor),
                self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
            self.tableView.backgroundColor = .clear
            self.tableView.separatorColor = .lightText
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    func setupHeader() {
        let cityName = String(weatherInfo?.timezone.split(separator: "/")[1]
            ?? "").replacingOccurrences(of: "_", with: " ")
        headerView = CustomHeaderView(frame: .zero,
                                      city: cityName,
                                      weatherCondition: weatherInfo?.current.weather.first?.weatherDescription ?? "",
                                      temperature: "\(Int(weatherInfo?.current.temp ?? 0))°")
        guard let headerView = headerView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 130.0)
        headerHeightConstraint?.isActive = true
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sectionsArray[section] {
        case .temperatureSection:
            return 0.0
        case .fullInfoSection:
            return 140.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sectionsArray[section] {
        case .temperatureSection:
            return nil
        case .fullInfoSection:
            guard let hourlyForecast = weatherInfo?.hourly else { return nil }
            return HourlyCollectionView(hourlyForecast: hourlyForecast)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionsArray[section] {
        case .temperatureSection:
            return 2
        case .fullInfoSection:
            return (weatherInfo?.daily.count ?? 0) + 5
        }
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch sectionsArray[indexPath.section] {
        case .temperatureSection:
            if indexPath.row == 0 {
                let model = TemperatureCellModel(currentTemperature: Int(weatherInfo?.current.temp ?? 0.0))
                cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
            }
            if indexPath.row == 1 {
                if let currentDate = ConvertationMethods.shared.dateFrom(unixDate: weatherInfo?.current.dt) {
                    let model = TodayHighLowTempCellModel(dayOfWeek: ConvertationMethods.shared.dayOfWeekFrom(date: currentDate),
                                                          dailyTemperature: Int(weatherInfo?.daily.first?.temp.day ?? 0.0),
                                                          nightTemperature: Int(weatherInfo?.daily.first?.temp.night ?? 0.0))
                    cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
                }
            }
        case .fullInfoSection:
            let dailyCount = weatherInfo?.daily.count ?? 0
            if indexPath.row < dailyCount - 1 {
                if let date = ConvertationMethods.shared.dateFrom(unixDate: weatherInfo?.daily[indexPath.row + 1].dt) {
                    let model = DailyForecastCellModel(dayOfTheWeek: ConvertationMethods.shared.dayOfWeekFrom(date: date),
                                                       dayTemperature: Int(weatherInfo?.daily[indexPath.row + 1].temp.day ?? 0.0),
                                                       nightTemperature: Int(weatherInfo?.daily[indexPath.row + 1].temp.night ?? 0.0),
                                                       conditionImageCode: weatherInfo?.daily[indexPath.row + 1].weather?.first?.icon)
                    cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
                }
            }
            if indexPath.row == dailyCount - 1 {
                let model = DescriptionCellModel(text: "Today: \(weatherInfo?.current.weather.first?.weatherDescription ?? "")" +
                    " currently. It's \(Int(weatherInfo?.current.temp ?? 0.0))°;" +
                "the high will be \(Int(weatherInfo?.daily.first?.temp.max ?? 0.0))°.")
                cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
            }
            if indexPath.row == dailyCount {
                if let sunriseDate = ConvertationMethods.shared.dateFrom(unixDate: weatherInfo?.current.sunrise),
                    let sunsetDate = ConvertationMethods.shared.dateFrom(unixDate: weatherInfo?.current.sunset) {
                    let model = AdditionalInfoCellModel(leftLabelName: "SUNRISE",
                                                        leftLabelVolume: ConvertationMethods.shared.take(info: .hoursAndMinutes, from: sunriseDate),
                                                        rightLabelName: "SUNSET",
                                                        rightLabelVolume: ConvertationMethods.shared.take(info: .hoursAndMinutes, from: sunsetDate))
                    cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
                }
            }
            if indexPath.row == dailyCount + 1 {
                let model = AdditionalInfoCellModel(leftLabelName: "CHANCE OF RAIN",
                                                    leftLabelVolume: "10 %",
                                                    rightLabelName: "HUMIDITY",
                                                    rightLabelVolume: "\(weatherInfo?.current.humidity ?? 0)" +
                                                    " %".replacingOccurrences(of: ".", with: ","))
                cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
            }
            if indexPath.row == dailyCount + 2 {
                    let model = AdditionalInfoCellModel(leftLabelName: "WIND",
                                                        leftLabelVolume: "\(ConvertationMethods.shared.convertDegreesToDirection(windDerection: weatherInfo?.current.windDeg ?? 0)) \(round((weatherInfo?.current.windSpeed ?? 0.0) * 100.0) / 100.0)" +
                                                        " m/s".replacingOccurrences(of: ".", with: ","),
                                                        rightLabelName: "FEELS LIKE",
                                                        rightLabelVolume: "\(Int(weatherInfo?.current.feelsLike ?? 0.0))°")
                    cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
            }
            if indexPath.row == dailyCount + 3 {
                    let model = AdditionalInfoCellModel(leftLabelName: "PRECIPITATION",
                                                        leftLabelVolume: "\(round(weatherInfo?.current.rain?.the1H ?? 0.0 * 10.0) / 100.0)" +
                                                        " cm".replacingOccurrences(of: ".", with: ","),
                                                        rightLabelName: "PRESSURE",
                                                        rightLabelVolume: "\(Double(weatherInfo?.current.pressure ?? 0) * 0.75)" +
                                                            "mm Hg".replacingOccurrences(of: ".", with: ","))
                    cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
            }
            if indexPath.row == dailyCount + 4 {
                    let model = AdditionalInfoCellModel(leftLabelName: "VISABILITY",
                                                        leftLabelVolume: "\((weatherInfo?.current.visibility ?? 0) / 1000) km".replacingOccurrences(of: ".", with: ","),
                                                        rightLabelName: "UV INDEX",
                                                        rightLabelVolume: "\(round((weatherInfo?.current.uvi ?? 0.0) * 10) / 10)".replacingOccurrences(of: ".", with: ","))
                    cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dailyCount = weatherInfo?.daily.count ?? 0
        switch sectionsArray[indexPath.section] {
        case .temperatureSection:
            if indexPath.row == 0 {
                return UIScreen.main.bounds.height / 4
            }
            if indexPath.row == 1 {
                return 40.0
            }
        case .fullInfoSection:
            if (0...dailyCount - 2).contains(indexPath.row) {
                return 40.0
            } else {
                return 75.0
            }
        }
        return 0.0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0.0 {
            changeCellsAlpha(offset: abs(pow(scrollView.contentOffset.y, 1.2)))
        }
        for cell in tableView.visibleCells {
            let calculatedY = cell.frame.origin.y - scrollView.contentOffset.y
            let temperatureCellIndex = IndexPath(row: 0, section: 0)
            let temperatureCell = tableView.cellForRow(at: temperatureCellIndex)
            if cell != temperatureCell {
                if calculatedY < 120.0 && calculatedY > 0.0 {
                    let hideAmount = 120.0 - calculatedY
                    maskCell(fromTop: hideAmount, cell: cell)
                } else
                    if (calculatedY > 0.0) {
                        maskCell(fromTop: 0.0, cell: cell)
                    } else
                        if (calculatedY < 0.0) {
                            maskCell(fromTop: cell.frame.height, cell: cell)
                }
            }
        }
    }
    // MARK: - these two methods make cells invisible under the header
    func maskCell(fromTop margin: CGFloat, cell: UITableViewCell) {
        cell.layer.mask = visibilityMask(withLocation: margin / cell.frame.size.height, cell: cell)
        cell.layer.masksToBounds = true
    }
    func visibilityMask(withLocation location: CGFloat, cell: UITableViewCell) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = cell.bounds
        mask.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
        let num = location as NSNumber
        mask.locations = [num, num]
        return mask
    }
    func changeCellsAlpha(offset: CGFloat) {
        let firstCellIndex = IndexPath(row: 0, section: 0)
        let firstCell = tableView.cellForRow(at: firstCellIndex)
        let secondCellIndex = IndexPath(row: 1, section: 0)
        let secondCell = tableView.cellForRow(at: secondCellIndex)
        if offset <= 100.0 {
            firstCell?.alpha = 1.0 - (offset / 100.0)
            secondCell?.alpha = 1.0 - (offset / 100.0)
        } else {
            firstCell?.alpha = 0.0
            secondCell?.alpha = 0.0
        }
    }
}
