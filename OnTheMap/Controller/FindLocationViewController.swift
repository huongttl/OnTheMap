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
    }

    @IBAction func findLocationButtonTapped(_ sender: Any) {
        /*
        if getGeo() == true && getMediaURL() == true {
            let nextVC = storyboard?.instantiateViewController(identifier: "AddLocationViewController") as! AddLocationViewController
            nextVC.location = currentStudentLocation
            nextVC.mediaURL = mediaURL
            nextVC.locationName = locationText.text ?? ""
            navigationController?.pushViewController(nextVC, animated: true)
        }*/
        getMediaURL()
        getGeo()
        let nextVC = storyboard?.instantiateViewController(identifier: "AddLocationViewController") as! AddLocationViewController
        nextVC.location = currentStudentLocation
        nextVC.mediaURL = mediaURL
        nextVC.locationName = locationText.text ?? ""
        navigationController?.pushViewController(nextVC, animated: true)
        
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
    
    func getGeo() {
        guard let text = locationText.text else {
            print("Location nil")
            showEmptyFailure()
            return
        }
        if isStringEmpty(string: text) {
            print("Location empty")
            showEmptyFailure()
//            return false
        }
        var isGetGeoDone = false
        CLGeocoder().geocodeAddressString(text) {
            geo, error in
            if error != nil {
                print("error location")
                isGetGeoDone = false
                self.showFailure(message: error?.localizedDescription ?? "")
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
        print("isGetGeoDone: \(isGetGeoDone)")
//        return isGetGeoDone
    }
    
    func getMediaURL(){
        guard let text = linkText.text else {
            print("Media Link nil")
            showEmptyFailure()
            return //false
        }
        if isStringEmpty(string: text) {
            print("Media Link empty")
            showEmptyFailure()
//            return false
        }
        mediaURL = text
//        return true
    }
    
    func showEmptyFailure() {
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertVC.title = "Missing info"
        alertVC.message = "Input the Location and Link"
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func showFailure(message: String) {
            let alertVC = UIAlertController(title: "Get location Failed", message: message, preferredStyle: .alert)
            print(message)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
}
