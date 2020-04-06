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
//        self.navigationItem.title = "Add Location"
//        self.navigationItem.backBarButtonItem?.title = "Cancel"
        // Do any additional setup after loading the view.
        addLocationMapView.delegate = self
        let currentLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        addLocationMapView.centerToLocation(currentLocation)
        self.reloadInputViews()
        self.viewAnnotation()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func submitButtonTapped(_ sender: Any) {
        print("location showed")
        print(location)
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        navigationController?.pushViewController(nextVC, animated: true)
        
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

//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let annotation = view.annotation else {
//            return
//        }
//        guard let subtitle = annotation.subtitle else {
//            return
//        }
//        guard let url = URL(string: subtitle ?? "") else {
//            return
//        }
//        UIApplication.shared.open(url)
//    }

}
