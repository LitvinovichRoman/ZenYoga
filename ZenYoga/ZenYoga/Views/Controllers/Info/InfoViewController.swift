//
//  InfoViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 05/12/2023.
//

import Firebase
import UIKit
import SafariServices

class InfoViewController: UIViewController {
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
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
    
    // Переход к странице  проекта на GitHub
    @IBAction func infoButton(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/LitvinovichRoman/ZenYoga") {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
    }
    

}
