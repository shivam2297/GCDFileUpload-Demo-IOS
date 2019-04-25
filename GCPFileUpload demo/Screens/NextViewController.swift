//
//  NextViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 15/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    var nextVC: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func uploadSceneBtnTapped(_ sender: Any) {
        nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadViewController")
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }

    @IBAction func multiUploadScenebtnTapped(_ sender: Any) {
        nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MultiUploadViewController")
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    @IBAction func schedulerSceneBtnTapped(_ sender: Any) {
        nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TaskSchedulerViewController")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
