//
//  NextViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 15/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        self.navigationController?.pushViewController(mainVC!, animated: true)
    }
    
    @IBAction func uploadSceneBtnTapped(_ sender: Any) {
        let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadViewController")
        self.navigationController?.pushViewController(uploadVC!, animated: true)
    }

}
