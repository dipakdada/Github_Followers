//
//  User.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 08/10/24.
//

import Foundation

struct User : Codable {
    let login       : String
    let avatarUrl   : String
    var name        : String?
    var location    : String?
    var bio         : String?
    let publicRepos : Int
    let publicGists : Int
    let followers   : Int
    let following   : Int
    let htmlUrl     : String
    let createdAt   : Date
}
