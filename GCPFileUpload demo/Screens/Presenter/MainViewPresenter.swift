//
//  MainViewPresenter.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 11/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import Foundation
import FirebaseStorage

class MainViewPresenter {

    private var mainView: MainViewDelegate?
    private let storage = Storage.storage()
    private let storagePath = "gs://cloud-storage-demo-7dc04.appspot.com/Screenshot 2019-03-26 at 11.11.41 AM.png"

    init(view: MainViewDelegate) {
        mainView = view
    }

    func getData() {
        let imageRef = storage.reference(forURL: storagePath)

        imageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error {
                self.mainView?.onDataError(message: error.localizedDescription)
            } else {
                self.mainView?.onDataSuccess(data: data!)
            }
        }
    }

}

extension MainViewPresenter: ResponseCallBack {


    func onSuccess() {
        print("Success")
    }

    func onError() {
        print("Failure")
    }

    
}
