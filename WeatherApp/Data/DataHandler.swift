//
//  FileManager.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import Foundation

class DataHandler {
    static let shared = DataHandler()
    private init() {}
    func writeDataToFile(data: Data, fileName: String) {
        let urls = FileManager.default.urls(for: .libraryDirectory, in: .allDomainsMask)
        guard let url = urls.first?.appendingPathComponent(fileName) else { return }
        do {
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    func readDataFromFile(fileName: String) -> Data? {
        let urls = FileManager.default.urls(for: .libraryDirectory, in: .allDomainsMask)
        guard let url = urls.first?.appendingPathComponent(fileName) else { return nil }
        var dataFromFile = Data()
        do {
            dataFromFile = try Data(contentsOf: url)
        } catch {
            print(error)
        }
        return dataFromFile
    }
    func parseData<T: Codable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
