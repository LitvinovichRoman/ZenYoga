//
//  PosesViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import UIKit

class PosesViewModel {
    
    // MARK: - Properties
    var imageURLs: [URL] = []
    
    // MARK: - Data Loading
    func loadImageURLs(completion: @escaping () -> Void) {
        FirebaseStorageService.shared.retrievePosesImageURLs { [weak self] result in
            switch result {
            case .success(let retrievedImageURLs):
                self?.imageURLs = retrievedImageURLs.sorted(by: { $0.absoluteString < $1.absoluteString })
                completion()
            case .failure(let error):
                print("Error retrieving image URLs: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Computed Properties
    var numberOfItems: Int {
        return imageURLs.count
    }
    
    // MARK: - Image Access
    func imageURL(at index: Int) -> URL {
        return imageURLs[index]
    }
}
