//
//  ViewController.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 11.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var locationManager = CLLocationManager()
    var weatherInfo: WeatherData?
    var sectionsArray: [SectionType] = [.temperatureSection, .fullInfoSection]
    var headerHeightConstraint: NSLayoutConstraint?
    var headerView: CustomHeaderView?
    var tableViewNotsetted = false
    let backgroundView: UIImageView = {
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "background")
        backgroundView.isUserInteractionEnabled = true
        return backgroundView
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .lightText
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: NibNames.todayHighLow.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: String(describing: TodayHighLowTempCellModel.CellType.self))
        tableView.register(UINib(nibName: NibNames.dailyForecast.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: String(describing: DailyForecastCellModel.CellType.self))
        tableView.register(UINib(nibName: NibNames.description.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: String(describing: DescriptionCellModel.CellType.self))
        tableView.register(UINib(nibName: NibNames.additionalInfo.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: String(describing: AdditionalInfoCellModel.CellType.self))
        tableView.register(UINib(nibName: NibNames.temperature.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: String(describing: TemperatureCellModel.CellType.self))
        return tableView
    }()
    override func loadView() {
        super.loadView()
        self.view = backgroundView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .dark
        readWeatherFromCache()
        checkSavedData()
        setupLocationManager()
    }
    private func readWeatherFromCache() {
        guard let dataFromFile = DataHandler.shared.readDataFromFile(fileName:
            Constants.dataFile.rawValue) else { return }
        do {
            weatherInfo = try DataHandler.shared.parseData(data: dataFromFile)
        } catch {}
    }
}
