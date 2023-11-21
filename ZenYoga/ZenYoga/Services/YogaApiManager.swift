//
//  YogaApiManager.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 21/11/2023.
//

import Foundation
import Alamofire

class YogaAPIManager {
    static let shared = YogaAPIManager()
    private let baseURL = "https://yoga-api-nzy4.onrender.com/v1"

    private init() {}

    func getCategories(completion: @escaping ([YogaCategory]?, Error?) -> Void) {
        let url = baseURL + "/categories"
        
        AF.request(url).validate().responseDecodable(of: [YogaCategory].self) { response in
            switch response.result {
            case .success(let categories):
                completion(categories, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getCategoryById(_ id: String, completion: @escaping (YogaCategory?, Error?) -> Void) {
        let url = baseURL + "/categories?id=\(id)"
        
        AF.request(url).validate().responseDecodable(of: YogaCategory.self) { response in
            switch response.result {
            case .success(let category):
                completion(category, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getCategoryByName(_ name: String, completion: @escaping (YogaCategory?, Error?) -> Void) {
        let url = baseURL + "/categories?name=\(name)"
        
        AF.request(url).validate().responseDecodable(of: YogaCategory.self) { response in
            switch response.result {
            case .success(let category):
                completion(category, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getCategoriesByLevel(_ id: String, level: String, completion: @escaping ([YogaPose]?, Error?) -> Void) {
        let url = baseURL + "/categories?id=\(id)&level=\(level)"
        
        AF.request(url).validate().responseDecodable(of: [YogaPose].self) { response in
            switch response.result {
            case .success(let poses):
                completion(poses, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getPoses(completion: @escaping ([YogaPose]?, Error?) -> Void) {
        let url = baseURL + "/poses"
        
        AF.request(url).validate().responseDecodable(of: [YogaPose].self) { response in
            switch response.result {
            case .success(let poses):
                completion(poses, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getPoseById(_ id: String, completion: @escaping (YogaPose?, Error?) -> Void) {
        let url = baseURL + "/poses?id=\(id)"
        
        AF.request(url).validate().responseDecodable(of: YogaPose.self) { response in
            switch response.result {
            case .success(let pose):
                completion(pose, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getPosesByLevel(level: String, completion: @escaping ([YogaPose]?, Error?) -> Void) {
        let url = baseURL + "/poses?level=\(level)"
        
        AF.request(url).validate().responseDecodable(of: [YogaPose].self) { response in
            switch response.result {
            case .success(let poses):
                completion(poses, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
