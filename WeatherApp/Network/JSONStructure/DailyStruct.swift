//
//  DailyData.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

struct Daily: Codable {
    let dt, sunrise, sunset, windDeg: Int
    let temp: Temp
    let feelsLike: FeelsLike?
    let pressure, humidity, clouds: Int?
    let dewPoint, windSpeed, uvi, rain: Double?
    let weather: [Weather]?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, weather, clouds, uvi, rain, pressure, humidity
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
    }
}
