//
//  Event.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/1/25.
//

import Foundation

struct Event: Codable {
    var name: String
    var bio: String
    var organizer: String
    var date: String
    var time: String
    var comments: [Comment] = []
}


struct Comment: Codable {
    var userName: User
    var text: String
    var Date: Date
}
