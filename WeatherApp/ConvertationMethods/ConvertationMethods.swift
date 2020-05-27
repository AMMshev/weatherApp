//
//  ConvertationMethods.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 14.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

enum InfoTypes: String {
    case hours = "HH"
    case hoursAndMinutes = "HH:mm"
    case fullDate = "yyyy-MM-dd"
}

class ConvertationMethods {
    static let shared = ConvertationMethods()
    private init() {}
    // MARK: - returns swift formatted date from UNIX formatted date
    func dateFrom(unixDate: Int?) -> Date? {
        let date = Date(timeIntervalSince1970: Double(unixDate ?? 0)).description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: date)
    }
    func take(info: InfoTypes, from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = info.rawValue
        return dateFormatter.string(from: date)
    }
    func dayOfWeekFrom(date: Date) -> String? {
        switch Calendar(identifier: .gregorian).component(.weekday, from: date) {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
    // MARK: - returns direction from degree
    func convertDegreesToDirection(windDerection: Int) -> String {
        switch windDerection {
        case 1...90:
            return "E"
        case 91...180:
            return "S"
        case 181...270:
            return "W"
        case 271...360, 0:
            return "N"
        default:
            return " "
        }
    }
}
