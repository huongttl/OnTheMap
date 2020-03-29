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
        // Do any additional setup after loading the view.
//        self.navig
        let data = Client.getStudentLocations() {
            (studentLocations, error) in
            DataModel.studentLocations = studentLocations
            print("count \(studentLocations.count)")
            self.tableView.reloadData()
        }
        print(data)
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
//        if let posterPath = movie.posterPath {
//            TMDBClient.downloadPosterImage(posterPath: posterPath) {
//                (data, error) in
//                guard let data = data else {
//                    return
//                }
//                let image = UIImage(data: data)
//                cell.imageView?.image = image
//                cell.setNeedsLayout()
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
//        performSegue(withIdentifier: "showDetail", sender: nil)
//        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: DataModel.studentLocations[indexPath.row].mediaURL) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
}
