//
//  LocationExtension.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        locationManager.stopUpdatingLocation()
        requestWeather(from: location)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            showLocationDisabledMessage()
        }
    }
    // MARK: - transfer location via URL to the server and when gets weather data reloads tableView
    func requestWeather(from location: CLLocationCoordinate2D) {
        CheckWeather.shared.initialize(withToken: Constants.token.rawValue)
        CheckWeather.shared.currentWeather(latitude: location.latitude,
                                           longitude: location.longitude)
        { [weak self] (data, error) in
            guard let self = self,
                let data = data else { return }
            DataHandler.shared.writeDataToFile(data: data, fileName: Constants.dataFile.rawValue)
            do {
                self.weatherInfo = try DataHandler.shared.parseData(data: data)
            } catch {
                print(error)
            }
            if self.tableViewNotsetted == true && self.weatherInfo != nil {
                self.setupTableView()
            }
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print(error ?? "")
            }
        }
    }
    // MARK: - if the location is disabled for this app shows alert
    func showLocationDisabledMessage() {
        let alert = UIAlertController(title: "Background location access disabled",
                                      message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(openAction)
        self.present(alert, animated: true, completion: nil)
    }
}
