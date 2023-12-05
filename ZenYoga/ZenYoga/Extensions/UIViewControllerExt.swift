//
//  UIViewControllerExt.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 25/11/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayWarning(withText text: String) {
        let alertController = UIAlertController(title: "Warning", message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Back", style: .cancel)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
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
    
}
