//
//  SettingViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 05/12/2023.
//

import Firebase
import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func exit(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
           if let login = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
               login.modalPresentationStyle = .fullScreen
               self.present(login, animated: true, completion: nil)
           }
    }
    

}
