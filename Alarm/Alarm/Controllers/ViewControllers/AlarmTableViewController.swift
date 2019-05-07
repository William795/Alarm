//
//  AlarmTableViewController.swift
//  Alarm
//
//  Created by William Moody on 5/6/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmTableViewCell
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell.updateCell(alarm: alarm)
    
        cell.delegate = self
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmEntry = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.deleteAlarm(alarmToDelete: alarmEntry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alarmSegue", let indexPath = tableView.indexPathForSelectedRow {
            let destinationVC = segue.destination as? AlarmViewController
            let alarm = AlarmController.shared.alarms[indexPath.row]
            destinationVC?.alarmEntry = alarm
        }
    }
}

extension AlarmTableViewController: AlarmTableViewCellDelegate {
    
    func toggleSettingForCell(cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleIsOn(alarm: alarm)
        cell.updateCell(alarm: alarm)
    }
}

//extension AlarmViewController: AlarmSchedualController{
//
//}
