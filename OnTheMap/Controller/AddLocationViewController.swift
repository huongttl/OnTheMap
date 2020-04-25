//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var addLocationMapView: MKMapView!
    
    var location = CLLocationCoordinate2D()
    var locationName = ""
    var mediaURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        addLocationMapView.delegate = self
        let currentLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        addLocationMapView.centerToLocation(currentLocation)
        self.reloadInputViews()
        self.viewAnnotation()
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        print("location showed")
        print(location)
        print("locationName: \(locationName); url: \(mediaURL)")
        Client.addStudentLocation(firstName: "Huong", lastName: "Tran", mapString: locationName, mediaURL: mediaURL, latitude: location.latitude, longtitude: location.longitude, completion: handleAddStudentLocationResponse(success:error:))
        }

    func handleAddStudentLocationResponse(success: Bool, error: Error?) {
        if success {
            print("Post OK")
            DispatchQueue.main.async {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        } else {
            print("falling")
            DispatchQueue.main.async {
                self.showAddStudentLocationFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func showAddStudentLocationFailure(message: String) {
        let alertVC = UIAlertController(title: "Post Student Location failed.", message: message, preferredStyle: .alert)
        print(message)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func viewAnnotation() {
        let annotation = StudentAnnotation(title: locationName, mediaURL: mediaURL, coordinate: location)
        print("view map count \(annotation)")
        addLocationMapView.addAnnotation(annotation)
    }
}
private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension AddLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "addLocationAnnotation"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .infoLight)
    }
    return view
  }

}
