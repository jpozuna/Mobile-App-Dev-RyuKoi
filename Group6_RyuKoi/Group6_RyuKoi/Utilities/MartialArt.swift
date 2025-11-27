//
//  MartialArt.swift
//  Group6_RyuKoi
//
//  Created by Allison Lee on 11/26/25.
//


import Foundation
import UIKit

enum MartialArt {
    case taekwondo
    case karate
    case boxing
    case mma
    case wrestling
    case judo
    case bjj
    case kickboxing
    case muayThai
    
    var color: UIColor {
        switch self {
        case .taekwondo:
            return UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0) // Blue
        case .karate:
            return UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 1.0) // Red
        case .boxing:
            return UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0) // Gold
        case .mma:
            return UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0) // Dark Gray
        case .wrestling:
            return UIColor(red: 0.6, green: 0.2, blue: 0.8, alpha: 1.0) // Purple
        case .judo:
            return UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0) // Green
        case .bjj:
            return UIColor(red: 0.1, green: 0.3, blue: 0.5, alpha: 1.0) // Dark Blue
        case .kickboxing:
            return UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 1.0) // Orange
        case .muayThai:
            return UIColor(red: 0.8, green: 0.2, blue: 0.4, alpha: 1.0) // Pink/Red
        }
    }
}
