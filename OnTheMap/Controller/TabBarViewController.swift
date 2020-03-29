//
//  UITabBarController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var reloadListButton: UIBarButtonItem!
    @IBOutlet weak var addLocationButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        sel
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logOutButtonTapped(_ sender: Any) {
//        let nextVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
//        navigationController?.pushViewController(nextVC, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func reloadListButtonTapped(_ sender: Any) {
        self.view.reloadInputViews()
    }
    @IBAction func addLocationButtonTapped(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(identifier: "FindLocationViewController") as! FindLocationViewController
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
