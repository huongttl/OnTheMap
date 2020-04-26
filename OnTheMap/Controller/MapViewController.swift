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
            DataModel.studentLocations = studentLocations
            print("count student \(studentLocations.count)")
            self.reloadInputViews()
            self.viewAnnotation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mapView.reloadInputViews()
    }

    func viewAnnotation() {
        var annotations = [StudentAnnotation]()
        for i in 0..<DataModel.studentLocations.count {
            let annotation = StudentAnnotation(title: "\(DataModel.studentLocations[i].firstName) \(DataModel.studentLocations[i].lastName)", mediaURL: DataModel.studentLocations[i].mediaURL, coordinate: CLLocationCoordinate2D(latitude: DataModel.studentLocations[i].latitude, longitude: DataModel.studentLocations[i].longitude))
                    annotations.append(annotation)
                }
        print("view map count \(annotations.count)")
        mapView.addAnnotations(annotations)
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
