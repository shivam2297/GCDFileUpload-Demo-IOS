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


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        presenter = UploadPresenter(view: self)
    }
    
    @IBAction func uploadBtnTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }


}

extension UploadViewController: UploadViewDelegate {
    func onDataSuccess() {
        
    }
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            
        }

        dismiss(animated: true, completion: nil)
    }
}
