//
//  Follower.swift
//  Github followers
//
//  Created by rs on 27.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation


struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
