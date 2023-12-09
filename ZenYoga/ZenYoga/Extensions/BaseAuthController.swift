//
//  BaseAuthController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 03/12/2023.
//

import UIKit
import Firebase

class BaseAuthController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - Properties
    var ref: DatabaseReference!
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!
    
    
    //MARK: - Auth Listener
    func authListener() {
        ref = Database.database().reference(withPath: "users")
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({[weak self] _, user in
            guard let _ = user  else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController {
                tabBarController.modalPresentationStyle = .fullScreen
                self!.present(tabBarController, animated: true, completion: nil)
            }
        })
    }
    
    //MARK: - Public Methods
    func displayWarning(withText text: String) {
        let alertController = UIAlertController(title: "Warning", message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Back", style: .cancel)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Setup Keyboard
    func keyboardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = 0
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y -= (keyboardSize.height / 2)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:) func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    func swipeAction() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
                swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
                self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func hideKeyboardOnSwipeDown() {
            view.endEditing(true)
        }
    
    deinit { NotificationCenter.default.removeObserver(self) }

}
