//
//  RequestBuilder.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

class RequestBuilder {
    private var serviceURL: String
    private var latitude: Double?
    private var longitude: Double?
    private var unitsFormat: UnitsFormats
    private var token: String?
    init() {
        self.serviceURL = Constants.weatherAPIURL.rawValue
        self.unitsFormat = UnitsFormats.metric
    }
    func setLatitude(latitude: Double) -> RequestBuilder {
        self.latitude = latitude
        return self
    }
    func setLongitude(longitude: Double) -> RequestBuilder {
        self.longitude = longitude
        return self
    }
    func setUnitsFormat(unitsFormat: UnitsFormats) -> RequestBuilder {
        self.unitsFormat = unitsFormat
        return self
    }
    func setToken(token: String?) -> RequestBuilder {
        self.token = token
        return self
    }
    func build() -> String {
        if let latitude = latitude {
            serviceURL += "lat=\(latitude)"
        }
        if let longitude = longitude {
            serviceURL += "&lon=\(longitude)"
        }
        switch unitsFormat {
        case .metric:
            serviceURL += "&units=metric"
        case .imperial:
            serviceURL += "&units=imperial"
        }
        if let token = token {
            serviceURL += "&appid=\(token)"
        }
        return serviceURL
    }
}
