//
//  User.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 22/04/2021.
//

import Foundation

struct User : Codable {
    let fullName : String
    let email : String
    let password : String?
}

