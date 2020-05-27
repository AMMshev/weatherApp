//
//  WatherMainData.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let lat, lon: Double?
    let timezone: String
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}
