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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return } // Получение идентификатора клиента из настроек Firebase
        
        let config = GIDConfiguration(clientID: clientID)  // Создание конфигурации для Google Sign-In с полученным идентификатором клиента
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in //Попытка  входа в систему с Google
            if let error = error {
                print("Google login error: \(error.localizedDescription)")
                return
            }
            
            guard let googleIDToken = user?.authentication.idToken,  // Получение токена идентификации Google
                  let googleAccessToken = user?.authentication.accessToken else { return } // Получение токена доступа Google
            
            let credential = GoogleAuthProvider.credential(withIDToken: googleIDToken,
                                                           accessToken: googleAccessToken)  // Создание учетных данных для Firebase с использованием токена идентификации и токена доступа Google
            
            Auth.auth().signIn(with: credential) { authResult, error in // Вход в Firebase с использованием учетных данных Google
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


