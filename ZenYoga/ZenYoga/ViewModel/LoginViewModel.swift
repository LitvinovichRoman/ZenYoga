//
//  LoginViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import Firebase

class LoginViewModel {
    
    // MARK: - Properties
    // Переменные для хранения почты и пароля пользователя
    var email: String?
    var password: String?
    
    func login(completion: @escaping (Error?) -> Void) {
        guard let email = email, !email.isEmpty, // Проверка почты на пустоту
              let password = password, !password.isEmpty //Проверка пароля на пустоту
        else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Info is incorrect"])) // Если информация некорректна, возвращаем ошибку
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in // Вход в Firebase с использованием электронной почты и пароля
            completion(error)
        }
    }
}
