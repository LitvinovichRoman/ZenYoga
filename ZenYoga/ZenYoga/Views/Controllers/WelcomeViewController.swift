//
//  WelcomeViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 25/11/2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.capsuleCornerRadius()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
}
