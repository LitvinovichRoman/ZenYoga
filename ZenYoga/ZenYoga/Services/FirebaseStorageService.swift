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
    
    // MARK: - Image Retrieval
    func retrieveAchievementsImages(completion: @escaping ([UIImage]?, Error?) -> Void) {
        let achievementsRef = storage.reference(withPath: "achievements")
        var images: [UIImage] = []
        
        achievementsRef.listAll { (result, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var imageCount = result!.items.count
            for imageRef in result!.items {
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
        }
    }
    
   
    
    func retrievePosesImageURLs(completion: @escaping (Result<[URL], Error>) -> Void) {
            let posesRef = storage.reference().child("poses")
            
            posesRef.listAll { (result, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    var urls: [URL] = []
                    
                    let dispatchGroup = DispatchGroup()
                    
                    for item in result!.items {
                        dispatchGroup.enter()
                        
                        item.downloadURL { url, error in
                            if let error = error {
                                print("Error getting download URL: \(error)")
                            } else if let url = url {
                                urls.append(url)
                            }
                            
                            dispatchGroup.leave()
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        completion(.success(urls))
                    }
                }
            }
        }
}




