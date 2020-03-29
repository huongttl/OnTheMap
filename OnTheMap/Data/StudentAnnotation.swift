//
//  StudentAnnotation.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/29/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import Foundation
import MapKit

class StudentAnnotation: NSObject, MKAnnotation {
  let title: String?
  let mediaURL: String
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, mediaURL: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.mediaURL = mediaURL
    self.coordinate = coordinate
    
    super.init()
  }
  
  var subtitle: String? {
    return mediaURL
  }
}
