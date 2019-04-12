//
//  MainViewPresenter.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 11/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import Foundation

class MainViewPresenter {

}

extension MainViewPresenter: ResponseCallBack {
    func onSuccess() {
        print("Success")
    }

    func onError() {
        print("Failure")
    }

    
}
