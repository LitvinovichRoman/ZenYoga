//
//  LoginViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 03/12/2023.
//

import UIKit
import FirebaseDatabaseInternal
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class LoginViewController: BaseAuthController {
    
    // MARK: - Outlets
    @IBOutlet private weak var subView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var registrationButton: UIButton!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var signInWithGoogleButton: GIDSignInButton!
    
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        authListener()
        setupUI()
        keyboardObserver()
    }
    
    // MARK: - Actions
    @IBAction private func loginButtonAction() {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        viewModel.login { [weak self] error in
            if let error = error {
                self?.displayWarning(withText: "SignIn was incorrect \n \n \(error)")
            }
        }
    }
    
    @IBAction private func registrationButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        if let registrationViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController {
            registrationViewController.modalPresentationStyle = .fullScreen
            self.present(registrationViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction private func signInWithGoogleButtonAction() {
        signInWithGoogle()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        swipeAction()
        subView.cornerRadius()
        emailTextField.cornerRadius()
        passwordTextField.cornerRadius()
        loginButton.capsuleCornerRadius()
        signInWithGoogleButton.capsuleCornerRadius()
    }
}
