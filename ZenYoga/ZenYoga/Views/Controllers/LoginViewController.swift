//
//  LoginViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 21/11/2023.
//


import UIKit
import Firebase

class LoginViewController: UIViewController {

    var viewModel = LoginViewModel()
  
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var subView: UIView!
    @IBOutlet weak private var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }
  
    @objc private func emailTextFieldDidChange() {
        viewModel.email = emailTextField.text ?? ""
    }
  
    @objc private func passwordTextFieldDidChange() {
        viewModel.password = passwordTextField.text ?? ""
    }

    @IBAction func loginButtonAction() {
           viewModel.signIn { [weak self] error in
               if let error = error {
                   self?.displayWarning(withText: "SignIn was incorrect \n \n \(error)")
               }
           } successHandler: {
               self.handleSuccessfulSignIn()
           }
       }

    @IBAction func registrationButtonAction(){
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        if let registrationViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController {
            registrationViewController.modalPresentationStyle = .fullScreen
            self.present(registrationViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func signInWithGoogleButton(_ sender: UIButton) {
    }
    
    
    private func handleSuccessfulSignIn() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController {
                mainTabBarController.modalPresentationStyle = .fullScreen
                self.present(mainTabBarController, animated: true, completion: nil)
            }
        }
    }
  
    private func setupUI() {
        emailTextField.cornerRadius()
        passwordTextField.cornerRadius()
        subView.cornerRadius()
        subView.setShadow()
        loginButton.capsuleCornerRadius()
    }
    
    deinit { NotificationCenter.default.removeObserver(self) }
}

