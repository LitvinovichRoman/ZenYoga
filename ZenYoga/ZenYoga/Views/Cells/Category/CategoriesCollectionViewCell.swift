//
//  CategoriesCollectionViewCell.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 03/12/2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriesImage: UIImageView!
    
    func setImage(_ image: UIImage) {
            categoriesImage.image = image
        }

}
