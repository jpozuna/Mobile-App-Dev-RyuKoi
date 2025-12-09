//
//  ProgressSpinnerViewController.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/9/25.
//

import UIKit

class ProgressSpinnerViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView!

        override func viewDidLoad() {
            super.viewDidLoad()
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.startAnimating()
            
            view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.25)
            view.addSubview(activityIndicator)
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
        }

}
