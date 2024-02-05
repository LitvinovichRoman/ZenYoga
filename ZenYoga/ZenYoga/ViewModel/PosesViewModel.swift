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
    var imageURLs: [URL] = [] // Массив для хранения URL-адресов изображений
    
    // MARK: - Data Loading
    func loadImageURLs(completion: @escaping () -> Void) {
        FirebaseStorageService.shared.retrievePosesImageURLs { [weak self] result in // Запрос на получение URL-адресов изображений из Firebase Storage
            switch result {
            case .success(let retrievedImageURLs):
                self?.imageURLs = retrievedImageURLs.sorted(by: { $0.absoluteString < $1.absoluteString }) // Сортировка полученных URL-адресов и сохранение их в массив
                completion()
            case .failure(let error):
                print("Error retrieving image URLs: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Computed Properties
    var numberOfItems: Int {
        return imageURLs.count  // Свойство для получения количества URL-адресов в массиве
    }
    
    // MARK: - Image Access
    func imageURL(at index: Int) -> URL {
        return imageURLs[index] // Получения URL-адреса изображения по индексу
    }
}
