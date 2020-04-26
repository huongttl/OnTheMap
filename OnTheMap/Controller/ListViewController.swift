//
//  SecondViewController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Table View")
        _ = Client.getStudentLocations() {
            (studentLocations, error) in
            DataModel.studentLocations = studentLocations
            print("count \(studentLocations.count)")
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count \(DataModel.studentLocations.count)")
        return DataModel.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableViewCell")!
        
        let studentLocation = DataModel.studentLocations[indexPath.row]
        
        cell.textLabel?.text = studentLocation.firstName + " " + studentLocation.lastName
        cell.imageView?.image = UIImage(named: "icon_pin")
        cell.detailTextLabel?.text = studentLocation.mediaURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        print(selectedIndex)
        guard let url = URL(string: DataModel.studentLocations[indexPath.row].mediaURL) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
