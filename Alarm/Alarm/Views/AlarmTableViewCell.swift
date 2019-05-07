//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by William Moody on 5/6/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

protocol AlarmTableViewCellDelegate: class {
    func toggleSettingForCell(cell: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var isOnSwitch: UISwitch!
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    func updateCell(alarm: Alarm) {
        TimeLabel.text = alarm.TimeAsString
        noteLabel.text = alarm.note
        isOnSwitch.isOn = alarm.isOn
        contentView.backgroundColor = alarm.isOn ? .red : .white
    }
    
    @IBAction func settingSwitchFlipped(_ sender: Any) {
        delegate?.toggleSettingForCell(cell: self)
    }
}
