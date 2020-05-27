//
//  Constants.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

enum Constants: String {
    case dataFile = "dataFile.txt"
    case token = "1166f1565b6de7f8163e7e7abc508b0a"
    case weatherAPIURL = "https://api.openweathermap.org/data/2.5/onecall?"
}

enum NibNames: String {
    case additionalInfo = "AdditionalInfoTableViewCell"
    case dailyForecast = "DailyForecastTableViewCell"
    case description = "DescriptionTableViewCell"
    case temperature = "TemperatureTableViewCell"
    case todayHighLow = "TodayHighLowTempTableViewCell"
}

enum CellIdentifiers: String {
    case additionalInfo = "additionalInfo"
    case dailyForecast = "dailyForecast"
    case dailyForecastCollection = "hourlyWeatherCell"
    case description = "description"
    case temperature = "temperatureCell"
    case todayHighLow = "todayHighLowTemp"
}
