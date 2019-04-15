//
//  ViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 11/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    private var mainPresenter: MainViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainPresenter = MainViewPresenter(view: self)
        mainPresenter.getData()
    }



}

extension MainViewController: MainViewDelegate {
    func onDataSuccess(data: Data) {
        imgView.image = UIImage(data: data)
    }

    func onDataError(message: String) {
        print(message)
    }


    func showLoader() {

    }

    func hideLoader() {

    }

    
}

