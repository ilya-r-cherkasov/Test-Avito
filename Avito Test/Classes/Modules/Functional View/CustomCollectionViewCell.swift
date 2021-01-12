//
//  CollectionViewCell.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 04.01.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "CustomCollectionView"
    
    private let iconImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        let url = URL(string:"https://www.avito.ru/s/common/components/monetization/icons/apps/vas-highlight-52.png")
            if let data = try? Data(contentsOf: url!)
            {
                imageView.image = UIImage(data: data)
            }
        
        return imageView
        
    }()
    
    private let titleLabel: UILabel = {

        let label = UILabel()
        label.text = "XL-объявление"
        return label
        
    }()
    
    private let descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска."
        return label
        
    }()
    
    private let costLabel: UILabel = {
        
        let label = UILabel()
        label.text = "354$"
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.sizeToFit()
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        contentView.addSubview(costLabel)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        costLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        costLabel.lineBreakMode = .byWordWrapping
        costLabel.numberOfLines = 0
        costLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        costLabel.sizeToFit()
        
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkmarkImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        checkmarkImageView.leadingAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.trailingAnchor, constant: 15).isActive = true
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
