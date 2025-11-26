//
//  GlobalFunctions.swift
//  Group6_RyuKoi
//
//  Created by R M on 11/19/25.
//

import Foundation
import UIKit


func onLogoTapped(from viewController: UIViewController) {
    let homeScreen = HomeViewController()
    viewController.navigationController?.pushViewController(homeScreen, animated: true)
}

func onAccountTapped(from viewController: UIViewController) {
    let profileScreen = ProfileViewController()
    viewController.navigationController?.pushViewController(profileScreen, animated: true)
}

