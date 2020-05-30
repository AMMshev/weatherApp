//
//  TableViewCellModel.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 31.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

protocol TableViewCellModel {
    associatedtype CellType: UIView
    func setupCell(cell: CellType)
}

struct AdditionalInfoCellModel {
    let leftLabelName: String
    let leftLabelVolume: String
    let rightLabelName: String
    let rightLabelVolume: String
}

extension AdditionalInfoCellModel: TableViewCellModel {
    func setupCell(cell: AdditionalInfoTableViewCell) {
        cell.leftLabelName = leftLabelName
        cell.leftLabelVolume = leftLabelVolume
        cell.rightLabelName = rightLabelName
        cell.rightLabelVolume = rightLabelVolume
    }
}

struct DailyForecastCellModel {
    let dayOfTheWeek: String?
    let dayTemperature: Int?
    let nightTemperature: Int?
    let conditionImageCode: String?
}

extension DailyForecastCellModel: TableViewCellModel {
    func setupCell(cell: DailyForecastTableViewCell) {
        cell.dayOfTheWeek = dayOfTheWeek
        cell.dayTemperature = dayTemperature
        cell.nightTemperature = nightTemperature
        cell.conditionImageCode = conditionImageCode
    }
}

struct DescriptionCellModel {
    let text: String
}

extension DescriptionCellModel: TableViewCellModel {
    func setupCell(cell: DescriptionTableViewCell) {
        cell.textLabel?.text = text
    }
}

struct TemperatureCellModel {
    let currentTemperature: Int
}

extension TemperatureCellModel: TableViewCellModel {
    func setupCell(cell: TemperatureTableViewCell) {
        cell.currentTemperature = currentTemperature
    }
}

struct TodayHighLowTempCellModel {
    let dayOfWeek: String?
    let dailyTemperature: Int?
    let nightTemperature: Int?
}

extension TodayHighLowTempCellModel: TableViewCellModel {
    func setupCell(cell: TodayHighLowTempTableViewCell) {
        cell.dayOfWeek = dayOfWeek
        cell.dailyTemperature = dailyTemperature
        cell.nightTemperature = nightTemperature
    }
}

extension UITableView {
    func dequeueReusableCell<T: TableViewCellModel>(withModel model: T,
                                                    for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: T.CellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? T.CellType {
            model.setupCell(cell: cell)
        }
        return cell
    }
}
