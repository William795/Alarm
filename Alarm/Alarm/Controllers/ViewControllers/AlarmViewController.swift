//
//  AlarmViewController.swift
//  Alarm
//
//  Created by William Moody on 5/6/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    var alarmEntry: Alarm?
    


    @IBOutlet weak var TitalLabel: UILabel!
    @IBOutlet weak var TimePicker: UIDatePicker!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var DisableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let time = alarmEntry?.time else {return}
        TimePicker.date = time
        noteTextField.text = alarmEntry?.note
        TitalLabel.text = alarmEntry?.note
        toggleDisableButton()
    }
    
    func toggleDisableButton(){
        if alarmEntry?.isOn == true{
            DisableButton.backgroundColor = .red
            DisableButton.setTitle("Disable", for: .normal)
            DisableButton.setTitleColor(.white, for: .normal)
            updateViewConstraints()
        }else{
            DisableButton.backgroundColor = .white
            DisableButton.setTitle("Enable", for: .normal)
            DisableButton.setTitleColor(.red, for: .normal)
            updateViewConstraints()
        }
    }
    
    @IBAction func SaveBarButtonItem(_ sender: Any) {
        
        guard let note = noteTextField.text else {return}
        
        if let alarm = self.alarmEntry{
            AlarmController.shared.updateAlarm(alarm: alarm, with: TimePicker.date, note: note)
            alarm.isOn = true
            navigationController?.popViewController(animated: true)
        }else {
            AlarmController.shared.createNewAlarm(timeFromUser: TimePicker.date, withNote: note)
            
            navigationController?.popViewController(animated: true)
            
            print("somthing")
        }
    }
    
    @IBAction func DisableAlarmButtonAction(_ sender: Any) {
        guard let toggle = alarmEntry else {return}
        AlarmController.shared.toggleIsOn(alarm: toggle)
        toggleDisableButton()
        updateViewConstraints()
    }
}


extension AlarmViewController: AlarmSchedualController{
    
}
