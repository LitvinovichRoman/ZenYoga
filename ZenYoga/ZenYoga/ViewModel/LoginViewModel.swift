//
//  LoginViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import Firebase

class LoginViewModel {
    var email: String = ""
    var password: String = ""

    func signIn(completion: @escaping (Error?) -> Void, successHandler: @escaping () -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            completion(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Email or password is empty"]))
            return
        }
            
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error {
                completion(error)
            } else if user != nil {
                successHandler()
                completion(nil)
            } else {
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No such user"]))
            }
        }
    }
}


