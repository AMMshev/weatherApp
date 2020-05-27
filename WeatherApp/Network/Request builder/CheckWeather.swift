//
//  CheckWeather.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

class CheckWeather {
    private static var token: String?
    static let shared = CheckWeather()
    private init() {}
    func initialize(withToken token: String) {
        CheckWeather.token = token
    }
// MARK: - transfers downloaded data using request builder and escaping closure
    func currentWeather(latitude: Double, longitude: Double, callback: @escaping(Data?, Error?) -> Void) {
        NetworkHandler.shared.get(from: RequestBuilder()
            .setLatitude(latitude: latitude)
            .setLongitude(longitude: longitude)
            .setToken(token: CheckWeather.token)
            .build(), callback: callback)
    }
}
