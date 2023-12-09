//
//  MainTabBarController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 26/11/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Regular", size: 23)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        super.viewDidLoad()
    }
}
