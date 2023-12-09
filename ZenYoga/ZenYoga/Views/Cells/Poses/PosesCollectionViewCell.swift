//
//  PosesCollectionViewCell.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 03/12/2023.
//

import UIKit

class PosesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posesImage: UIImageView!
    
    func setImage(_ image: UIImage) {
            posesImage.image = image
        }

}
