//
//  Alarm.swift
//  Alarm
//
//  Created by William Moody on 5/6/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation

class Alarm: Codable{
    var time: Date
    var note: String
    var isOn: Bool
    var uuid: String
    
    var TimeAsString: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
    
    init(time: Date, note: String, isOn: Bool = true, uuid: String = UUID().uuidString) {
        self.time = time
        self.note = note
        self.isOn = isOn
        self.uuid = uuid
    }
}

extension Alarm: Equatable{
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.note == rhs.note && lhs.time == rhs.time && lhs.isOn == rhs.isOn
    }
}
