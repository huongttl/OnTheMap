//
//  FindLocationViewController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit
import MapKit

class FindLocationViewController: UIViewController {

    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    
    var currentStudentLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var mediaURL = ""
    
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
        

//        CLGeocoder().geocodeAddressString(locationText.text) {
//            locationGeo, error inputView
//        }
        if getGeo() == true && getMediaURL() == true {
            let nextVC = storyboard?.instantiateViewController(identifier: "AddLocationViewController") as! AddLocationViewController
            nextVC.location = currentStudentLocation
            nextVC.mediaURL = mediaURL
            nextVC.locationName = locationText.text ?? ""
            navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
    func isStringEmpty(string: String) -> Bool {
        if string == "" {
            print("Link is empty")
            return true
        } else {
            print("Link is not empty")
            return false
        }
    }
    
    func getGeo() -> Bool {
        guard let text = locationText.text else {
            print("Location nil")
            return false
        }
        if isStringEmpty(string: text) {
            print("Location empty")
            return false
        }
        var isGetGeoDone = true
        CLGeocoder().geocodeAddressString(text) {
            geo, error in
            if error != nil {
                print("error location")
                isGetGeoDone = false
                print(error?.localizedDescription)
                return
            } else {
                if let lat = geo?.first?.location?.coordinate.latitude {
                    self.currentStudentLocation.latitude = lat
                }
                if let long = geo?.first?.location?.coordinate.longitude {
                    self.currentStudentLocation.longitude = long
                }
                print("Location:")
                print(self.currentStudentLocation)
                isGetGeoDone = true
            }
        }
        return isGetGeoDone
    }
    
    func getMediaURL() -> Bool {
        guard let text = linkText.text else {
            print("Media Link nil")
            return false
        }
        if isStringEmpty(string: text) {
            print("Media Link empty")
            return false
        }
        mediaURL = text
        return true
    }
}
