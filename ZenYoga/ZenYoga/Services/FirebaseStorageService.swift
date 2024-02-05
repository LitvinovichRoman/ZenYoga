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
    static let shared = FirebaseStorageService() // Создание экземпляра класса FirebaseStorageService
    let storage = Storage.storage() // Получение ссылки на хранилище Firebase
    
    // MARK: - Image Retrieval
    func retrievePosesImageURLs(completion: @escaping (Result<[URL], Error>) -> Void) {
        let posesRef = storage.reference().child("poses") // Получение ссылки на папку "poses" в хранилище
        
        posesRef.listAll { (result, error) in   // Получение списка всех файлов в папке "poses"
            if let error = error {
                completion(.failure(error))     // Если произошла ошибка, возвращаем ошибку
            } else {
                var urls: [URL] = []            // Инициализация массива для хранения URL-адресов изображений
                
                let dispatchGroup = DispatchGroup()  // Создание группы для синхронизации загрузки URL-адресов
                
                for item in result!.items {
                    dispatchGroup.enter()
                    
                    item.downloadURL { url, error in
                        if let error = error {     // Если произошла ошибка, выводим ошибку
                            print("Error getting download URL: \(error)")
                        } else if let url = url {
                            urls.append(url)      // Если URL-адрес получен, добавляем его в массив
                        }
                        
                        dispatchGroup.leave()    // Выход из группы
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(.success(urls))       //когда все URL загружены, возвращаем массив адресов 
                }
            }
        }
    }
}




