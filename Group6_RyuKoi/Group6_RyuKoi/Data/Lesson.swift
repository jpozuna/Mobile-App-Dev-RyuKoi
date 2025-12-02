//
//  Lesson.swift
//  Group6_RyuKoi
//
//  Created by Allison Lee on 11/26/25.
//

import Foundation
import UIKit

struct Lesson: Codable {
    var title: String
    var description: String
    var progressState: LessonProgressState
    var progressPercentage: Int
    var practice: Practice
}

struct Practice: Codable {
    var PracticeMove: Data
    var tips: String
}

enum LessonProgressState: String, Codable {
    case notStarted
    case inProgress
    case completed
    case retry
}

