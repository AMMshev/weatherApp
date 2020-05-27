//
//  DescriptionTableViewCell.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 14.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.numberOfLines = 3
        textLabel?.textColor = .white
        isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
