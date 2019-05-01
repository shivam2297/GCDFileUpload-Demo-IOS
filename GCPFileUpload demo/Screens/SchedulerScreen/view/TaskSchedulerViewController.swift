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

    private var data: Data!

    var request: URLRequest = URLRequest(url: URL(string: "http://172.18.4.199:8000/test.mov")!)

    var responseData = Data()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = TaskSchedulerPresenter(view: self)
    }


    override func viewDidAppear(_ animated: Bool) {

        let fileUrl = Bundle.main.url(forResource: "sample_video_2", withExtension: "MOV")
        data = try? Data(contentsOf: fileUrl!)

        var d = 1.0
        while 1 < 2 {
            DispatchQueue(label: "task").asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(5000))) {
                //                        let r: Int = Int.random(in: ClosedRange(uncheckedBounds: (lower: 0, upper: 200)))
                d += 1
//                print("performing task: \(d)")
                //                self.showNotifications(r: r)

                if 1000.0.truncatingRemainder(dividingBy: d) == 0.0 {
                    self.uploadFiles()
                    print("performing task: \(d)")
                }
            }
        }

//                self.uploadFiles()
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

extension TaskSchedulerViewController: URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {


    func uploadFiles() {
        request.httpMethod = "POST"
        request.setValue("Keep Alive", forHTTPHeaderField: "Connection")
        let configurtion = URLSessionConfiguration.default
        let session = URLSession(configuration: configurtion, delegate: self, delegateQueue: OperationQueue.main)
        //        task.resume()

//        DispatchQueue(label: "task").asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(exactly: 60000000000.00)!)) {
        let task = session.uploadTask(with: self.request, from: self.data)
            task.resume()
//        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("error occured \(error.localizedDescription)")
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        var progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        print("uploading progress: \(progress * 100)%")
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("Recieved response: \(response)")
        completionHandler(URLSession.ResponseDisposition.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        showNotifications(r: 100)
        responseData.append(data)
    }

}
