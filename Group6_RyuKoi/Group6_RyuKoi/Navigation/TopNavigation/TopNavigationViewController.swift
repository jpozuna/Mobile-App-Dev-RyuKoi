//
//  TopNavigationViewController.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class TopNavigationViewController: UIViewController {
    let topNav = TopNavigationBarView()
    
    override func loadView() {
        view = topNav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
}
