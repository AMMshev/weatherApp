//
//  TempDataStruct.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

struct FeelsLike: Codable {
    let day, night, eve, morn: Double?
}

struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double?
}
