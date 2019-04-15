//
//  UploadViewDelegate.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 15/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import Foundation

protocol UploadViewDelegate: AnyObject {
    func onDataSuccess(downloadUrl: String)
    func onDataError(message: String)
    func onProgressChanged(progress: Float)
}
