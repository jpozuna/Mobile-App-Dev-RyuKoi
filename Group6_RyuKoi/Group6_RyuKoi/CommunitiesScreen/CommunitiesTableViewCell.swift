//
//  CommunitiesTableViewCell.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
// MARK: TODO
// need to add more little details to each event cell square

import UIKit

class CommunitiesTableViewCell: UITableViewCell {
    var leftEventView: UIView!
    var rightEventView: UIView!
    
    var leftLabel: UILabel!
    var rightLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLessonViews()
        initConstraints()
    }

    func setupLessonViews() {
        leftEventView = makeEventBox()
        leftEventView = makeEventBox()

        leftLabel = makeLabel(in: leftEventView)
        rightLabel = makeLabel(in: rightEventView)
    }

    func makeEventBox() -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        v.layer.cornerRadius = 12
        v.layer.shadowColor = UIColor.gray.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 4
        v.layer.shadowOffset = .zero
        v.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(v)
        return v
    }

    func makeLabel(in parent: UIView) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(label)
        return label
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            leftEventView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leftEventView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            leftEventView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            rightEventView.topAnchor.constraint(equalTo: leftEventView.topAnchor),
            rightEventView.leadingAnchor.constraint(equalTo: leftEventView.trailingAnchor, constant: 12),
            rightEventView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            rightEventView.bottomAnchor.constraint(equalTo: leftEventView.bottomAnchor),

            rightEventView.widthAnchor.constraint(equalTo: leftEventView.widthAnchor),

            leftEventView.heightAnchor.constraint(equalTo: leftEventView.widthAnchor),
            rightEventView.heightAnchor.constraint(equalTo: rightEventView.widthAnchor),

            leftLabel.centerXAnchor.constraint(equalTo: leftEventView.centerXAnchor),
            leftLabel.centerYAnchor.constraint(equalTo: leftEventView.centerYAnchor),
            
            rightLabel.centerXAnchor.constraint(equalTo: rightEventView.centerXAnchor),
            rightLabel.centerYAnchor.constraint(equalTo: rightEventView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
