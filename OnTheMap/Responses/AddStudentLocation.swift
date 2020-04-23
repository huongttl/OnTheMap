//
//  AddStudentLocation.swift
//  OnTheMap
//
//  Created by Huong Tran on 4/24/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import Foundation

struct AddStudentLocation: Codable {
    let createdAt, objectID: String

    enum CodingKeys: String, CodingKey {
        case createdAt
        case objectID = "objectId"
    }
}
