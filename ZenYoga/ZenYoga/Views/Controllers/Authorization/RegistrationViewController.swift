//
//  RegistrationViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 03/12/2023.
//

import UIKit
import FirebaseDatabaseInternal
import FirebaseAuth

class RegistrationViewController: BaseAuthController {
    
    // MARK: - Outlets
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    
    // MARK: - Properties
    private var viewModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        keyboardObserver()
        authListener()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
        
    
    // MARK: - Actions
    @IBAction func registrationButtonAction() {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        viewModel.register { [weak self] error in
            if let error = error {
                self?.displayWarning(withText: "Registration was incorrect \n \n \(error) \n ")
            }
        }
       
    }
    
    @IBAction func backToLoginScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Setup UI
    private func setupUI(){
        swipeAction()
        subView.cornerRadius()
        emailTextField.cornerRadius()
        passwordTextField.cornerRadius()
        registrationButton.capsuleCornerRadius()
    }
}

