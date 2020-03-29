//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/24/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    let createdAt, firstName, lastName: String
    let latitude, longitude: Double
    let mapString: String
    let mediaURL: String
    let objectID, uniqueKey, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt, firstName, lastName, latitude, longitude, mapString, mediaURL
        case objectID = "objectId"
        case uniqueKey, updatedAt
    }
}
