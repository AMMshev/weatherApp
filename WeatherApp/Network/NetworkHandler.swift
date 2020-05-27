//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 11.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

class NetworkHandler {
    static let shared = NetworkHandler()
    private init() {}

    func get(from url: String, callback: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                callback(nil, error)
            }
            guard let data = data else { return }
                callback(data, nil)
        }.resume()
    }
}
