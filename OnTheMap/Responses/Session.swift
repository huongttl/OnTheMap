//
//  Session.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/29/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import Foundation
// MARK: - Session
struct Session: Codable {
    let account: Account
    let session: SessionClass
}

// MARK: - Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: - SessionClass
struct SessionClass: Codable {
    let id, expiration: String
}
