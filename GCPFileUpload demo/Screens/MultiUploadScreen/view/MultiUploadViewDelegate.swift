//
//  MultiUploadViewDelegate.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 22/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import Foundation

protocol MultiUploadViewDelegate {
    func onUploadSuccess(downloadUrl: String, fileId: String)
    func onUploadFailure(message: String, fileId: String)
    func onProgressChanged(progress: Float, fileId: String)
}
