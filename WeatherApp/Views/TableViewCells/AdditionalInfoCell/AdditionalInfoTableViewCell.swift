//
//  AdditionalInfoTableViewCell.swift
//  WeatherApp
//
//  Created by Artem Manyshev on 12.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class AdditionalInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var leftSideNameLabel: UILabel!
    @IBOutlet weak var leftSideVolumeLabel: UILabel!
    @IBOutlet weak var rightSideNameLabel: UILabel!
    @IBOutlet weak var rightSideVolumeLabel: UILabel!
    var leftLabelName: String?
    var leftLabelVolume: String?
    var rightLabelName: String?
    var rightLabelVolume: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        separatorInset.left = 10.0
        separatorInset.right = 20.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        leftSideNameLabel.text = leftLabelName
        leftSideVolumeLabel.text = leftLabelVolume
        rightSideNameLabel.text = rightLabelName
        rightSideVolumeLabel.text = rightLabelVolume
    }
}
