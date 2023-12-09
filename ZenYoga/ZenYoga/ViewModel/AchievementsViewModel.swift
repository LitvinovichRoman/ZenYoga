//
//  AchievementsViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import UIKit

class AchievementsViewModel {
    // MARK: - Properties
    var images: [UIImage] = []
    
    // MARK: - Data Loading
    func loadImages(completion: @escaping () -> Void) {
        FirebaseStorageService.shared.retrieveAchievementsImages { [weak self] (retrievedImages, error) in
            if let error = error {
                print("Error retrieving images: \(error.localizedDescription)")
            } else if let retrievedImages = retrievedImages {
                self?.images = retrievedImages
                completion()
            }
        }
    }
    
    // MARK: - Computed Properties
    var numberOfItems: Int {
        return images.count
    }
    
    // MARK: - Image Access
    func image(at index: Int) -> UIImage {
        return images[index]
    }
}
