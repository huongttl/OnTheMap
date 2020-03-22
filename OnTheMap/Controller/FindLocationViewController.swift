//
//  FindLocationViewController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit

class FindLocationViewController: UIViewController {

    @IBOutlet weak var findLocationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Location"
//        self.navigationItem.leftBarButtonItem?.title = "Cancel"
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

    @IBAction func findLocationButtonTapped(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(identifier: "AddLocationViewController") as! AddLocationViewController
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
