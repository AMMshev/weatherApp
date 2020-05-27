//
//  TemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 16.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    var currentTemperature: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = false
        separatorInset = UIEdgeInsets(top: 0.0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0.0)
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        temperatureLabel.text = "\(currentTemperature ?? 0)°"
    }
}
