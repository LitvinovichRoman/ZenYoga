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
    var email: String?
    var password: String?
    
    func register(completion: @escaping (Error?) -> Void) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty
        else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Information is incorrect"]))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let newUser = authResult?.user {
                let userReference = Database.database().reference(withPath: "users").child(newUser.uid)
                userReference.setValue(["email": newUser.email])
            }
            completion(error)
        }
    }
    
}
