//
//  CurrentData.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

struct Current: Codable {
    let dt, sunrise, sunset, pressure, humidity, windDeg: Int
    let temp, feelsLike, dewPoint, uvi, windSpeed: Double
    let clouds, visibility: Int?
    let weather: [Weather]
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds, visibility, weather, rain
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
    }
}
