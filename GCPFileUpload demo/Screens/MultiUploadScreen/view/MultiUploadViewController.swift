//
//  MultiUploadViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 22/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit
import QBImagePickerController
import UserNotifications

class MultiUploadViewController: UIViewController {

    @IBOutlet weak var uploadingContentTableView: UITableView!

    private var presenter: MultiUploadPresenter!

    private let cellIdentifier = "UploadContentTableViewCell"

    private var uploadContents = [UploadContent]()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = MultiUploadPresenter(view: self)
        uploadingContentTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        uploadingContentTableView.dataSource = self
        uploadingContentTableView.register(UINib(nibName: "UploadContentTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

    }

    @IBAction func addBtnTapped(_ sender: Any) {

        let imagePicker: QBImagePickerController = QBImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsMultipleSelection = true
        imagePicker.showsNumberOfSelectedAssets = true

        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }
}


extension MultiUploadViewController: MultiUploadViewDelegate {
    func onUploadSuccess(downloadUrl: String, fileId: String) {

    }

    func onUploadFailure(message: String, fileId: String) {

    }

    func onProgressChanged(progress: Float, fileId: String) {
//        progressBar.progress = progress / 100
//        uploadProgressLbl.text = "uploading: \((100 * progress).rounded()/100)%"

        let content = uploadContents.filter({return $0.fileId == fileId}).first
        content?.progress = progress
        let index = uploadContents.firstIndex(where: {$0.fileId == fileId})

        uploadingContentTableView.reloadRows(at: [IndexPath(row: index ?? 0, section: 0)], with: .automatic)

        if progress >= 100 {
            showNotifications(progress: "Upload Completed Successfully", fileId: fileId)
        }else {
            showNotifications(progress: "\((100 * progress).rounded()/100)%", fileId: fileId)
        }
    }


    func showNotifications(progress: String, fileId: String) {
        let content = UNMutableNotificationContent()
        content.title = "File Upload"
        content.subtitle = fileId
        content.body = progress

        //        content.categoryIdentifier = "RE_NOTIFY"

        //        content.sound = UNNotificationSound.default

        let notifyRequest = UNNotificationRequest(identifier: fileId, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(exactly: 0.01)!, repeats: false))

        //        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        UNUserNotificationCenter.current().add(notifyRequest) { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension MultiUploadViewController: QBImagePickerControllerDelegate {
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        imagePickerController.dismiss(animated: true, completion: nil)

        if assets.count > 0 {
            for i in 0..<assets.count {
                let asset = assets[i] as! PHAsset

                asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { [weak self] (contentEditingInput, dictInfo) in
                    if let strURL = contentEditingInput?.fullSizeImageURL
                    {
                        print("image url: \(strURL)")
                        self?.uploadContents.append(UploadContent(path: strURL.absoluteString, progress: 0, fileId: strURL.absoluteString))
                        self?.uploadingContentTableView.reloadData()
                        if let data = try? Data(contentsOf: strURL) {
                            self?.presenter.uploadData(data: data, fileId: strURL.absoluteString)
                        }
                    }
                }
            }
        }
    }
}

extension MultiUploadViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uploadContents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! UploadContentTableViewCell
        cell.contentNameLbl.text = uploadContents[indexPath.row].fileId
        cell.contentProgressBar.progress = uploadContents[indexPath.row].progress/100
        cell.progressLbl.text = "\((100 * uploadContents[indexPath.row].progress).rounded()/100)%"
        return cell
    }


}


class UploadContent {
    public var path: String
    public var progress: Float
    public var fileId: String

    init(path: String, progress: Float, fileId: String) {
        self.path = path
        self.progress = progress
        self.fileId = fileId
    }
}
