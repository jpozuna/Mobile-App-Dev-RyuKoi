//
//  HomeTableViewCell.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    var leftLessonView: UIView!
    var rightLessonView: UIView!
    
    var leftLabel: UILabel!
    var rightLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLessonViews()
        initConstraints()
    }

    func setupLessonViews() {
        leftLessonView = makeLessonBox()
        rightLessonView = makeLessonBox()

        leftLabel = makeLabel(in: leftLessonView)
        rightLabel = makeLabel(in: rightLessonView)
    }

    func makeLessonBox() -> UIView {
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
            leftLessonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leftLessonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            leftLessonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            rightLessonView.topAnchor.constraint(equalTo: leftLessonView.topAnchor),
            rightLessonView.leadingAnchor.constraint(equalTo: leftLessonView.trailingAnchor, constant: 12),
            rightLessonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            rightLessonView.bottomAnchor.constraint(equalTo: leftLessonView.bottomAnchor),

            rightLessonView.widthAnchor.constraint(equalTo: leftLessonView.widthAnchor),

            leftLessonView.heightAnchor.constraint(equalTo: leftLessonView.widthAnchor),
            rightLessonView.heightAnchor.constraint(equalTo: rightLessonView.widthAnchor),

            leftLabel.centerXAnchor.constraint(equalTo: leftLessonView.centerXAnchor),
            leftLabel.centerYAnchor.constraint(equalTo: leftLessonView.centerYAnchor),
            
            rightLabel.centerXAnchor.constraint(equalTo: rightLessonView.centerXAnchor),
            rightLabel.centerYAnchor.constraint(equalTo: rightLessonView.centerYAnchor)
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
