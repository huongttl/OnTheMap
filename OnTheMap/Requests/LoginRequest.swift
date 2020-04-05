//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/29/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import Foundation

// MARK: - Session
struct LoginRequest: Codable {
    let udacity: Udacity
}

// MARK: - Udacity
struct Udacity: Codable {
    let username, password: String
}
