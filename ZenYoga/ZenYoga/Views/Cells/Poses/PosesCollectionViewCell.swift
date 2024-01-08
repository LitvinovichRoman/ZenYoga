//
//  PosesCollectionViewCell.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 03/12/2023.
//

import UIKit
import Kingfisher

class PosesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var posesImage: UIImageView!
    
    func setImage(with url: URL) {
        posesImage.kf.setImage(with: url)
    }
}
