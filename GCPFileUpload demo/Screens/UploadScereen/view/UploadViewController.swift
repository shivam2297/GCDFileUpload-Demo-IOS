//
//  UploadViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 15/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    private var presenter: UploadPresenter!
    private var imagePicker: UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        presenter = UploadPresenter(view: self)
        progressBar.progress = 0
    }
    
    @IBAction func uploadBtnTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }


}

extension UploadViewController: UploadViewDelegate {
    func onProgressChanged(progress: Float) {
        progressBar.progress = progress
    }


    func onDataSuccess(downloadUrl: String) {
        print(downloadUrl)
        let alertVC = UIAlertController(title: "File Uploaded", message: "image uploaded successfully", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "ok", style: .default, handler: { [weak self] (action) in
            self?.progressBar.progress = 0
        }))
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }

    func onDataError(message: String) {
        print(message)
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
