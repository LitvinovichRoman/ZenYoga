//
//  RegistrationViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 21/11/2023.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
  
    var viewModel = RegistrationViewModel()
  
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }
  
    @IBAction func registrationButtonAction() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        viewModel.createUser(email: email, password: password, completion: { [weak self] error in
            if let error = error {
                self?.displayWarning(withText: "Registration was incorrect \n \n \(error)")
            }
        }, successHandler: {
            self.handleSuccessfulRegistration()
        })
    }

    
    @objc private func emailTextFieldDidChange() {
        viewModel.email = emailTextField.text ?? ""
    }
  
    @objc private func passwordTextFieldDidChange() {
        viewModel.password = passwordTextField.text ?? ""
    }
      
    private func handleSuccessfulRegistration() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Authorization", bundle: nil) // Fixed the typo in "Authorization"
            if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
  
    private func setupUI(){
        subView.cornerRadius()
        subView.setShadow()
        emailTextField.capsuleCornerRadius()
        passwordTextField.capsuleCornerRadius()
        registrationButton.capsuleCornerRadius()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
  
}


