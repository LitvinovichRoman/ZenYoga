//
//  AchievementsCell.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 03/12/2023.
//

import UIKit

class AchievementsCell: UICollectionViewCell {
    
    @IBOutlet weak var achievementsImage: UIImageView!
    
    func setImage(_ image: UIImage) {
        if let imageView = achievementsImage {
            imageView.image = image
            setNeedsLayout()
        }
    }

}

