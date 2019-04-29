//
//  TaskSchedulerViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 25/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit
import UserNotifications

class TaskSchedulerViewController: UIViewController {

    private var presenter: TaskSchedulerPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = TaskSchedulerPresenter(view: self)
    }


    override func viewDidAppear(_ animated: Bool) {
//        while 1 < 2 {
//            DispatchQueue(label: "task").asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(5000))) {
//                let r: Int = Int.random(in: ClosedRange(uncheckedBounds: (lower: 0, upper: 200)))
//                print("performing task: \(r)")
////                self.showNotifications(r: r)
//            }
//        }
    }


    func showNotifications(r: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Background Task"
        content.body = "performing task: \(r)"

        //        content.categoryIdentifier = "RE_NOTIFY"

        //        content.sound = UNNotificationSound.default

        let notifyRequest = UNNotificationRequest(identifier: "task", content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(exactly: 0.1)!, repeats: false))

        //        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        UNUserNotificationCenter.current().add(notifyRequest) { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }


}

extension TaskSchedulerViewController: TaskSchedulerViewDelegate {

}

extension TaskSchedulerViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    }

}
