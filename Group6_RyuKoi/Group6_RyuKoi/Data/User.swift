//
//  User.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/1/25.
//

import UIKit
import Foundation

struct User: Codable {
    var name: String
    var email: String
    var password: String
    var favoriteLessons: [Lesson] = []
    var notifications: [Notifications] = []
    var lessonProgress: [LessonProgress] = []
}

struct LessonProgress: Codable {
    var lessonName: String
    var progressPercent: Int
    var lastPracticeDate: Date
    var completed: Bool
}


struct Notifications: Codable {
    var title: String
    var message: String
    var date: Date
}
