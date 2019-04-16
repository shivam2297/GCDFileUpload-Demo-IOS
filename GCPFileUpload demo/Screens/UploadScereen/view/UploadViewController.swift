//
//  UploadViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 15/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit
import UserNotifications

class UploadViewController: UIViewController {

    private var presenter: UploadPresenter!
    private var imagePicker: UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var uploadProgressLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        presenter = UploadPresenter(view: self)
        progressBar.progress = 0
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func uploadBtnTapped(_ sender: Any) {
        //        imagePicker.allowsEditing = false
        //        imagePicker.sourceType = .photoLibrary
        //        imagePicker.delegate = self
        //        self.navigationController?.present(imagePicker, animated: true, completion: nil)

        let fileUrl = Bundle.main.url(forResource: "sample_video", withExtension: "mp4")

        presenter.uploadFile(url: fileUrl!)

        //        do {
        //            let data = try Data(contentsOf: fileUrl!)
        //            presenter.uploadData(data: data)
        //        } catch {
        //            print(error.localizedDescription)
        //        }

    }


}

extension UploadViewController: UploadViewDelegate {
    func onProgressChanged(progress: Float) {
        progressBar.progress = progress / 100
        uploadProgressLbl.text = "uploading: \((100 * progress).rounded()/100)%"

        //        if UIApplication.shared.applicationState == .background {
                    showNotifications(progress: "\((100 * progress).rounded()/100)%")
        //        }
    }

    func showNotifications(progress: String) {
        let content = UNMutableNotificationContent()
        content.title = "File Upload"
        content.body = progress

        //        content.categoryIdentifier = "RE_NOTIFY"

        //        content.sound = UNNotificationSound.default

        let notifyRequest = UNNotificationRequest(identifier: "file_upload_notify_req", content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(exactly: 0.01)!, repeats: false))

        //        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        UNUserNotificationCenter.current().add(notifyRequest) { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }


    func onDataSuccess(downloadUrl: String) {
        print(downloadUrl)
        progressBar.progress = 1.0
        uploadProgressLbl.text = "uploading: 100%"
        showNotifications(progress: "100%")
        let alertVC = UIAlertController(title: "File Uploaded", message: "image uploaded successfully", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "ok", style: .default, handler: { [weak self] (action) in
            self?.progressBar.progress = 0
            self?.uploadProgressLbl.text = "start upload"
        }))
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }

    func onDataError(message: String) {
        print(message)
    }


}

extension UploadViewController: UNUserNotificationCenterDelegate {


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.actionIdentifier)

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.body)

    }
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        dismiss(animated: true, completion: nil)

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let data = UIImage.jpegData(pickedImage)
            presenter.uploadData(data: data(0.5)!)
        }
    }
}
