//
//  TaskSchedulerViewController.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 25/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit

class TaskSchedulerViewController: UIViewController {

    private var presenter: TaskSchedulerPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = TaskSchedulerPresenter(view: self)
    }



}

extension TaskSchedulerViewController: TaskSchedulerViewDelegate {

}
