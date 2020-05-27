//
//  CurrentData.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

struct Current: Codable {
    let dt, sunrise, sunset: Int
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int?
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, rain
    }
}
