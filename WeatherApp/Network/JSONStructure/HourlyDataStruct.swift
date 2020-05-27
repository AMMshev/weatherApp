//
//  HourlyDataStruct.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

struct Hourly: Codable {
    let dt: Int
    let temp, feelsLike: Double
    let pressure, humidity: Int?
    let dewPoint: Double?
    let clouds: Int?
    let windSpeed: Double?
    let windDeg: Int
    let weather: [Weather]
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, temp, pressure, humidity, clouds, weather, rain
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
    }
}
