//
//  LoginViewControllerExt.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 05/12/2023.
//

import Foundation
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

extension LoginViewController {
    //MARK: - Google Sign In
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error {
                print("Google login error: \(error.localizedDescription)")
                return
            }
            
            guard let googleIDToken = user?.authentication.idToken,
                  let googleAccessToken = user?.authentication.accessToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: googleIDToken,
                                                           accessToken: googleAccessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Authentication Error: \(error.localizedDescription)")
                    self.displayWarning(withText: "Google login error")
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController {
                       tabBarController.modalPresentationStyle = .fullScreen
                        self.present(tabBarController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}


