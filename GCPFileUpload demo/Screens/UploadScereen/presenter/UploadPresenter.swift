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


    /// Upload data
    ///
    /// - Parameter data: data to be uploaded.
    func uploadData(data: Data) {

        //creating refrence for an image file
        let imageRef = Storage.storage().reference().child(randomString() + ".jpeg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let uploadTask = imageRef.putData(data, metadata: metadata)

        //observer for prgress
        uploadTask.observe(.progress) { [weak self] (snapshot) in
            // Upload reported progress
            let percentComplete = 100.0 * Float(snapshot.progress!.completedUnitCount)
                / Float(snapshot.progress!.totalUnitCount)

            self?.uploadView?.onProgressChanged(progress: percentComplete)
        }

        //observer for failure
        uploadTask.observe(.failure) { [weak self] (snapshot) in
            self?.uploadView?.onDataError(message: "Upload failed")
        }

        //observer for success
        uploadTask.observe(.success) { [weak self] (snapshot) in
            imageRef.downloadURL(completion: { (url, error) in
                if let downloadUrl = url {
                    self?.uploadView?.onDataSuccess(downloadUrl: downloadUrl.absoluteString)
                    uploadTask.removeAllObservers()
                }
            })
        }
    }


    /// Upload file from url.
    ///
    /// - Parameter url: local url of file.
    func uploadFile(url: URL) {

        //creating refrence for a video file
        let fileRef = Storage.storage().reference().child(randomString() + ".mp4")
        let metadata = StorageMetadata()
        metadata.contentType = "video/mp4"

        let uploadTask = fileRef.putFile(from: url, metadata: metadata)

        //observer for progress
        uploadTask.observe(.progress) { [weak self] (snapshot) in

            // Upload reported progress
            let percentComplete = 100.0 * Float(snapshot.progress!.completedUnitCount)
                / Float(snapshot.progress!.totalUnitCount)

            self?.uploadView?.onProgressChanged(progress: percentComplete)
        }

        //observer for failure
        uploadTask.observe(.failure) { [weak self] (snapshot) in
            self?.uploadView?.onDataError(message: "Upload failed")
        }

        //observer for success
        uploadTask.observe(.success) { [weak self] (snapshot) in
            fileRef.downloadURL(completion: { (url, error) in
                if let downloadUrl = url {
                    print("uploaded")
                    self?.uploadView?.onDataSuccess(downloadUrl: downloadUrl.absoluteString)
                    uploadTask.removeAllObservers()
                }
            })
        }
    }


    /// Random String Gen.
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
