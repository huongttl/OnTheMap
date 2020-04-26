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
    }

    @IBAction func logOutButtonTapped(_ sender: Any) {
        Client.logout{
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func reloadListButtonTapped(_ sender: Any) {
        self.view.reloadInputViews()
//        tabBarController?.reloadInputViews()
//        MapViewController.reloadInputViews()
    }
    @IBAction func addLocationButtonTapped(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(identifier: "FindLocationViewController") as! FindLocationViewController
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
