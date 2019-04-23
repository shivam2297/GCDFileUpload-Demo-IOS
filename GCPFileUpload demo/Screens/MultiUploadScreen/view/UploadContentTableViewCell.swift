//
//  UploadContentTableViewCell.swift
//  GCPFileUpload demo
//
//  Created by Daffolspmac-67 on 22/04/19.
//  Copyright © 2019 Daffodil Software. All rights reserved.
//

import UIKit

class UploadContentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentNameLbl: UILabel!
    @IBOutlet weak var contentProgressBar: UIProgressView!
    @IBOutlet weak var progressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        contentProgressBar.progress = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
