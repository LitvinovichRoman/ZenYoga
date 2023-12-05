//
//  RegistrationViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import Firebase

class RegistrationViewModel {
    var ref: DatabaseReference // Removed the implicitly unwrapped optional
    var email: String = "" // Initialize with an empty string to avoid nil value
    var password: String = "" // Initialize with an empty string to avoid nil value

    init() {
        ref = Database.database().reference() // Initialize the ref with a DatabaseReference
    }
    
    func createUser(email: String, password: String, completion: @escaping (Error?) -> Void, successHandler: @escaping () -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            completion(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Email or password is empty"]))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let error = error {
                completion(error)
            } else if let user = user {
                let userRef = self.ref.child(user.user.uid)
                userRef.setValue(["email": user.user.email])
                successHandler()
                completion(nil)
            }
        }
    }
}
