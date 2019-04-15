//
//  UploadPresenter.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 15/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import Foundation
import FirebaseStorage

class UploadPresenter {
    private var uploadView: UploadViewDelegate?

    init(view: UploadViewDelegate) {
        uploadView = view
    }


    func uploadData(data: Data) {
        let imageRef = Storage.storage().reference().child(randomString() + ".jpeg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let uploadTask = imageRef.putData(data, metadata: metadata)

        uploadTask.observe(.progress) { [weak self] (snapshot) in
//            let progress = Float(exactly: snapshot.progress?.fractionCompleted ?? 0)

            // Upload reported progress
            let percentComplete = 100.0 * Float(snapshot.progress!.completedUnitCount)
                / Float(snapshot.progress!.totalUnitCount)

            self?.uploadView?.onProgressChanged(progress: percentComplete)
        }

        uploadTask.observe(.failure) { [weak self] (snapshot) in
            self?.uploadView?.onDataError(message: "Upload failed")
        }

        uploadTask.observe(.success) { [weak self] (snapshot) in
            imageRef.downloadURL(completion: { (url, error) in
                if let downloadUrl = url {
                    self?.uploadView?.onDataSuccess(downloadUrl: downloadUrl.absoluteString)
                    uploadTask.removeAllObservers()
                }
            })
        }

//        imageRef.putData(data, metadata: metadata) { [weak self] (metadata, error) in
//            guard metadata != nil else {
//                self?.uploadView?.onDataError(message: "An error occured")
//                return
//            }
//
//            imageRef.downloadURL(completion: { (url, error) in
//                if let downloadUrl = url {
//                    self?.uploadView?.onDataSuccess(downloadUrl: downloadUrl.absoluteString)
//                }
//            })
//
//        }
    }

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
