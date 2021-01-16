//
//  CollectionViewCell.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 04.01.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "CustomCollectionView"
    var data: ListCell? {
        didSet {
            guard let data = data else { return }
            iconImageView.image = data.icon.image
            titleLabel.text = data.title
            descriptionLabel.text = data.listDescription
            priceLabel.text = data.price
            checkmarkImageView.isHidden = data.checkMarkIsHidden
        }
    }
    
    private let iconImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark")
        return imageView
        
    }()
    
    private let titleLabel: UILabel = {

        let label = UILabel()
        label.text = "Заголовок"
        return label
        
    }()
    
    private let descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Описание"
        return label
    }()
    
    private let priceLabel: UILabel = {
        
        let label = UILabel()
        label.text = "123$"
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark")
        return imageView
    }()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        iconImageView.sizeToFit()
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        titleLabel.sizeToFit()
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.numberOfLines = 0
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        priceLabel.sizeToFit()
        
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkmarkImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkmarkImageView.leadingAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.trailingAnchor, constant: 15).isActive = true
        checkmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32.5).isActive = true
        checkmarkImageView.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.layer.backgroundColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        self.layer.cornerRadius = 10.0
    }
}
