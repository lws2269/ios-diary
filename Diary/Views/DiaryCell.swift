//
//  DiaryCell.swift
//  Diary
//
//  Created by jin on 12/21/22.
//

import UIKit

final class DiaryCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.stackView.addArrangedSubview(dateLabel)
        self.stackView.addArrangedSubview(weatherIconImageView)
        self.stackView.addArrangedSubview(contentLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(stackView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func configureData(title: String, content: String, dateString: String) {
        self.titleLabel.text = title
        self.contentLabel.text = content
        self.dateLabel.text = dateString
    }
    
    private func configureConstraints() {
        self.dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.contentLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constant.spacing),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constant.spacing),
            self.titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -(Constant.spacing * 2)),
            
            self.stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constant.spacing),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constant.spacing),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constant.spacing),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Constant.spacing),
            
            self.dateLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            self.weatherIconImageView.heightAnchor.constraint(equalToConstant: 18),
            self.weatherIconImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
}
