//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    


    @IBAction func loginButtonTapped(_ sender: Any) {
        let tabVC = storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
        navigationController?.pushViewController(tabVC, animated: true
        )
    }
}
