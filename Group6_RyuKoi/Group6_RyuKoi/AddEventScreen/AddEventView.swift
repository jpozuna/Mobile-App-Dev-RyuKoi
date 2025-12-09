//
//  AddEventView.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/7/25.
//

import UIKit

class AddEventView: UIView {
    var backBtn: UIButton!
    var navBar: TopNavigationBarView!
    var eventDetailsContainer: UIView!
    var eventDetails: UILabel!
    var detailsContainer: UIView!
    var titleLabel: UILabel!
    var titleTextField: UITextField!
    var dateLabel: UILabel!
    var dateTextField: UITextField!
    var timeLabel: UILabel!
    var timeTextField: UITextField!
    var descriptionLabel: UILabel!
    var descriptionTextField: UITextView!
    var submitBtn: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupBackBtn()
        setupNavBar()
        setupAddEventPage()
        initConstraints()
    }
    
    func setupBackBtn() {
        backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.tintColor = .label
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backBtn)
    }
    
    func setupNavBar() {
        navBar = TopNavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(navBar)
    }
    
    func setupAddEventPage() {
        eventDetailsContainer = UIView()
        eventDetails = UILabel()
        detailsContainer = UIView()
        titleLabel = UILabel()
        titleTextField = UITextField()
        dateLabel = UILabel()
        dateTextField = UITextField()
        timeLabel = UILabel()
        timeTextField = UITextField()
        descriptionLabel = UILabel()
        descriptionTextField = UITextView()
        submitBtn = UIButton()
        
        eventDetailsContainer.backgroundColor = UIColor(red: 184/255, green: 57/255, blue: 14/255, alpha: 0.67)
        eventDetailsContainer.layer.cornerRadius = 20
        eventDetailsContainer.clipsToBounds = true
        eventDetailsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(eventDetailsContainer)
        
        eventDetails.textColor = .black
        eventDetails.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        eventDetails.text = "Event Details"
        eventDetails.translatesAutoresizingMaskIntoConstraints = false
        eventDetailsContainer.addSubview(eventDetails)
        
        detailsContainer.backgroundColor = UIColor(red: 238/255, green: 208/255, blue: 141/255, alpha: 1.0)
        detailsContainer.layer.cornerRadius = 13
        detailsContainer.clipsToBounds = true
        detailsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailsContainer)
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.text = "Event Name"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(titleLabel)
        
        titleTextField.placeholder = "Enter Event Name"
        titleTextField.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 232/255, alpha: 1.0)
        titleTextField.layer.cornerRadius = 15
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(titleTextField)
        
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        dateLabel.text = "Date"
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(dateLabel)
        
        dateTextField.placeholder = "Enter Event Date"
        dateTextField.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 232/255, alpha: 1.0)
        dateTextField.layer.cornerRadius = 15
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(dateTextField)
        
        timeLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        timeLabel.text = "Time"
        timeLabel.textColor = .black
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(timeLabel)
        
        timeTextField.placeholder = "Enter Event Time"
        timeTextField.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 232/255, alpha: 1.0)
        timeTextField.layer.cornerRadius = 15
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(timeTextField)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        descriptionLabel.text = "Event Bio"
        descriptionLabel.textColor = .black
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(descriptionLabel)
        
        descriptionTextField = UITextView()
        descriptionTextField.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 232/255, alpha: 1.0)
        descriptionTextField.layer.cornerRadius = 15
        descriptionTextField.font = UIFont.systemFont(ofSize: 15)
        descriptionTextField.isScrollEnabled = true
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(descriptionTextField)
        
        submitBtn = UIButton()
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.backgroundColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        submitBtn.layer.cornerRadius = 5
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.addSubview(submitBtn)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            backBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            navBar.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60),
            
            eventDetailsContainer.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20),
            eventDetailsContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            eventDetailsContainer.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            eventDetailsContainer.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            eventDetails.centerXAnchor.constraint(equalTo: eventDetailsContainer.centerXAnchor),
            eventDetails.centerYAnchor.constraint(equalTo: eventDetailsContainer.centerYAnchor),
            
            detailsContainer.topAnchor.constraint(equalTo: eventDetailsContainer.bottomAnchor, constant: 20),
            detailsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            detailsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 16),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 16),
            
            dateTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            dateTextField.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 16),
            dateTextField.widthAnchor.constraint(equalTo: detailsContainer.widthAnchor, multiplier: 0.45),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: dateTextField.trailingAnchor, constant: 16),
            
            timeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            timeTextField.leadingAnchor.constraint(equalTo: dateTextField.trailingAnchor, constant: 16),
            timeTextField.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -16),
            timeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 16),
            
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextField.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 16),
            descriptionTextField.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -16),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 150),
            
            submitBtn.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            submitBtn.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -16),
            submitBtn.widthAnchor.constraint(equalToConstant: 100),
            submitBtn.heightAnchor.constraint(equalToConstant: 40),
            
            eventDetailsContainer.widthAnchor.constraint(equalToConstant: 220),
            eventDetailsContainer.heightAnchor.constraint(equalToConstant: 60),

            detailsContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    func setAccountTarget(_ target: Any?, action: Selector) {
        navBar.account.addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
