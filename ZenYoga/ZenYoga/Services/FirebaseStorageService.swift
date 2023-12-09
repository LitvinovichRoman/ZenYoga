//
//  FirebaseStorageService.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 29/11/2023.
//

import Foundation
import FirebaseStorage
import UIKit

class FirebaseStorageService {
    
    // MARK: - Properties
    static let shared = FirebaseStorageService()
    let storage = Storage.storage()
    let storageRef: StorageReference
    
    // MARK: - Initialization
    private init() {
        storageRef = storage.reference(withPath: "achievements")
    }
    
    // MARK: - Image Retrieval
    func retrieveAchievementsImages(completion: @escaping ([UIImage]?, Error?) -> Void) {
        var images: [UIImage] = []
        
        storageRef.listAll { (result, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let result = result {
                var imageCount = result.items.count
                for imageRef in result.items {
                    imageRef.getData(maxSize: 99000) { data, error in
                        if let error = error {
                            completion(nil, error)
                        } else if let data = data, let image = UIImage(data: data) {
                            images.append(image)
                            imageCount -= 1
                            if imageCount == 0 {
                                DispatchQueue.main.async {
                                    completion(images, nil)
                                }
                            }
                        }
                    }
                }
            } else {
                let error = NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Result is nil"])
                completion(nil, error)
            }
        }
    }
        
    // MARK: - Category Image Retrieval
    func retrieveCategoryImages(completion: @escaping ([UIImage]?, Error?) -> Void) {
        var images: [UIImage] = []
            
        storageRef.listAll { (result, error) in
            if let error = error {
                completion(nil, error)
                return
            }
                
            if let result = result {
                var imageCount = result.prefixes.count
                for categoryRef in result.prefixes {
                    let categoryImageRef = categoryRef.child("category_name.jpg")
                    categoryImageRef.getData(maxSize: 99000) { data, error in
                        if let error = error {
                            completion(nil, error)
                        } else if let data = data, let image = UIImage(data: data) {
                            images.append(image)
                            imageCount -= 1
                            if imageCount == 0 {
                                completion(images, nil)
                            }
                        }
                    }
                }
            } else {
                let error = NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Result is nil"])
                completion(nil, error)
            }
        }
    }
}

