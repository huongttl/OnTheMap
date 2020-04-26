//
//  FirstViewController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        _ = Client.getStudentLocations() {
            (studentLocations, error) in
            if error != nil {
                self.showLoadFailure(message: error?.localizedDescription ?? "")
            } else {
                DataModel.studentLocations = studentLocations
                print("count student \(studentLocations.count)")
                self.reloadInputViews()
                self.viewAnnotation()
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.reloadInputViews()
    }

    func viewAnnotation() {
        var annotations = [StudentAnnotation]()
        for i in 0..<DataModel.studentLocations.count {
            let annotation = StudentAnnotation(title: "\(DataModel.studentLocations[i].firstName) \(DataModel.studentLocations[i].lastName)", mediaURL: DataModel.studentLocations[i].mediaURL, coordinate: CLLocationCoordinate2D(latitude: DataModel.studentLocations[i].latitude, longitude: DataModel.studentLocations[i].longitude))
                    annotations.append(annotation)
                }
        mapView.addAnnotations(annotations)
    }
    
    func showLoadFailure(message: String) {
        let alertVC = UIAlertController(title: "Load Student Location Failed", message: message, preferredStyle: .alert)
        print(message)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "annotation"
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

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation else {
            return
        }
        guard let subtitle = annotation.subtitle else {
            return
        }
        guard let url = URL(string: subtitle ?? "") else {
            return
        }
        UIApplication.shared.open(url)
    }

}
