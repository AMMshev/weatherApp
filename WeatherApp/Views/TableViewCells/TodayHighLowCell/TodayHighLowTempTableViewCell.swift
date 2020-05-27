//
//  TodayHighLowTempTableViewCell.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 13.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class TodayHighLowTempTableViewCell: UITableViewCell {
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dailyTemperatureLabel: UILabel!
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    var dayOfWeek: String?
    var dailyTemperature: Int?
    var nightTemperature: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0.0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        dayOfWeekLabel.text = dayOfWeek
        dailyTemperatureLabel.text = String(dailyTemperature ?? 0)
        nightTemperatureLabel.text = String(nightTemperature ?? 0)
    }
}
