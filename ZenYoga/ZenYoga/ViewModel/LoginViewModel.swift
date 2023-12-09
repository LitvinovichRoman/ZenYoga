//
//  LoginViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import Firebase

class LoginViewModel {
    var email: String?
    var password: String?
    
    func login(completion: @escaping (Error?) -> Void) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty
        else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Info is incorrect"]))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
}
