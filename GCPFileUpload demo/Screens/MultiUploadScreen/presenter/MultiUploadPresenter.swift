//
//  MultiUploadpresenter.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 22/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import Foundation
import FirebaseStorage

class MultiUploadPresenter {

    private var multiUploadView: MultiUploadViewDelegate?
    private let storageRef = Storage.storage().reference()

    init(view: MultiUploadViewDelegate) {
        multiUploadView = view
    }

    /// Upload data
    ///
    /// - Parameter data: data to be uploaded.
    func uploadData(data: Data, fileId: String) {

        //creating refrence for an image file
        let fileRef = storageRef.child("images/" + randomString() + ".jpeg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let uploadTask = fileRef.putData(data, metadata: metadata)

        addObservers(uploadTask: uploadTask, fileRef: fileRef, fileId: fileId)
    }

    /// This method adds various observers to upload task.
    ///
    /// - Parameters:
    ///   - uploadTask: upload task
    ///   - fileRef: file reference
    func addObservers(uploadTask: StorageUploadTask, fileRef: StorageReference, fileId: String) {
        //observer for prgress
        uploadTask.observe(.progress) { [weak self] (snapshot) in
            // Upload reported progress
            let percentComplete = 100.0 * Float(snapshot.progress!.completedUnitCount)
                / Float(snapshot.progress!.totalUnitCount)

            self?.multiUploadView?.onProgressChanged(progress: percentComplete, fileId: fileId)
        }

        //observer for failure
        uploadTask.observe(.failure) { [weak self] (snapshot) in
            self?.multiUploadView?.onUploadFailure(message: "Upload failed: \(snapshot.error?.localizedDescription)", fileId: fileId)
        }

        //observer for success
        uploadTask.observe(.success) { [weak self] (snapshot) in
            fileRef.downloadURL(completion: { (url, error) in
                if let downloadUrl = url {
                    self?.multiUploadView?.onUploadSuccess(downloadUrl: downloadUrl.absoluteString, fileId: fileId)
                    uploadTask.removeAllObservers()
                }
            })
        }
    }


    ///
    /// - Returns: A random string of 16 chars.
    func randomString() -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        let randomString : NSMutableString = NSMutableString(capacity: 16)

        for _ in 0..<16 {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }

        return randomString as String
    }

}
