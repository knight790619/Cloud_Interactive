//
//  PhotosCollectionViewCell.swift
//  Cloud_Interactive
//
//  Created by Marines Chin on 2019/9/20.
//  Copyright © 2019 chin. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImage.image = nil
        self.idLabel.text = nil
        self.titleLabel.text = nil
    }
    
}
