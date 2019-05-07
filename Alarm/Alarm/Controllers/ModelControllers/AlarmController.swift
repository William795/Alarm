//
//  AlarmController.swift
//  Alarm
//
//  Created by William Moody on 5/6/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation
import UserNotifications


class AlarmController {
    
    static let shared = AlarmController()
    
    private init(){
        alarms = loadFromPersistantStore()
    }
    
    var alarms: [Alarm] = []
    
    //CRUD
    func createNewAlarm(timeFromUser newtime: Date, withNote newNote: String) {
        let newAlarm = Alarm(time: newtime, note: newNote)
        alarms.append(newAlarm)
        isEnabled(for: newAlarm)
        saveToPersistantStore()
    }

    func updateAlarm(alarm: Alarm, with time: Date, note: String) {
        alarm.note = note
        alarm.time = time
        isEnabled(for: alarm)
        saveToPersistantStore()
    }
    
    func deleteAlarm(alarmToDelete: Alarm) {
        guard let indexOfAlarmToDelete = alarms.index(of: alarmToDelete) else {return}
        alarms.remove(at: indexOfAlarmToDelete)
        
        saveToPersistantStore()
    }
    
    // Switch is on or off
    func toggleIsOn(alarm: Alarm){
        alarm.isOn = !alarm.isOn
        if alarm.isOn == true{
            isEnabled(for: alarm)
        }else{
            notEnabled(for: alarm)
        }
    }
    
    // saving/loading data
    func fileURL() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "Alarm.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        
        return fullURL
    }
    
    func saveToPersistantStore() {
        let jsonEncoder = JSONEncoder()
        do{
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileURL())
        }catch{
            print(error)
        }
    }
    
    func loadFromPersistantStore() -> [Alarm] {
        let jsonDecoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileURL())
            let alarmEntry = try jsonDecoder.decode([Alarm].self, from: data)
            return alarmEntry
        }catch{
            print(error)
        }
        return[]
    }
}


protocol AlarmSchedualController: class {
    func isEnabled(for alarm: Alarm)
    func notEnabled(for alarm: Alarm)
}
extension AlarmSchedualController{
    
    func isEnabled(for alarm: Alarm){
        
        let content = UNMutableNotificationContent()
        content.title = "\(alarm.TimeAsString)"
        content.body = "\(alarm.note)"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Error scheduling local user notification \(error.localizedDescription) : \(error)")
            }
        }
    }
    
    func notEnabled(for alarm: Alarm){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}


extension AlarmController: AlarmSchedualController{
    
}
