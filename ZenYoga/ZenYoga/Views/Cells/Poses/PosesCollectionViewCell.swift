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
    
    // Изменение прозрачности при выборе ячейки
    override var isSelected: Bool { didSet { contentView.alpha = isSelected ? 0.5 : 1 } } 
    
    // Сброс состояния ячейки  
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = true
    }
    
    
    
    func setImage(with url: URL) {
        posesImage.kf.setImage(with: url) // Асинхронной загрузка изображения с помощью KingFisher
    }
}
