//
//  RegistrationViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal

class RegistrationViewModel {
    
    // MARK: - Properties
    
    // // Переменные для хранения пароля и почты пользователя
    var email: String?
    var password: String?
    
    func register(completion: @escaping (Error?) -> Void) {
        guard let email = email, !email.isEmpty, // Проверка почты на пустоту
              let password = password, !password.isEmpty // Проверка пароля на пустоту
        else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Information is incorrect"]))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in // Создание пользователя с помощью Firebase
            if let newUser = authResult?.user {
                let userReference = Database.database().reference(withPath: "users").child(newUser.uid)
                userReference.setValue(["email": newUser.email])
            }
            completion(error) //Возвращение ошибок если они есть 
        }
    }
    
}
