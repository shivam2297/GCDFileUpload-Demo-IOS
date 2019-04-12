//
//  ViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 11/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit
import FirebaseStorage

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let storage = Storage.storage()
    }


}

extension MainViewController: MainViewDelegate {
    
}

