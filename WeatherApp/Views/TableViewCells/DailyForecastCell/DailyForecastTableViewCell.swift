//
//  DailyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 13.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayTemperatureLabel: UILabel!
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    var dayOfTheWeek: String?
    var dayTemperature: Int?
    var nightTemperature: Int?
    var conditionImageCode: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0.0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0.0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        dayOfTheWeekLabel.text = dayOfTheWeek
        dayTemperatureLabel.text = String(dayTemperature ?? 0)
        nightTemperatureLabel.text = String(nightTemperature ?? 0)
        weatherImageView.image = UIImage(named: conditionImageCode ?? "")
    }
}
