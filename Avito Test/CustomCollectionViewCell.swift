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
        imageView.image = UIImage(named: "vas-xl-52")
        //imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "XL-объявление"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска. Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска"
        //label.backgroundColor = .yellow
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        //contentView.addSubview(iconImageView)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.backgroundColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        self.layer.cornerRadius = 10.0
        
        iconImageView.frame = CGRect(x: 15,
                               y: 15,
                               width: 55,
                               height: 55)
        
        titleLabel.frame = CGRect(x: 100,
                               y: 15,
                               width: contentView.frame.size.width - 115,
                               height: 50)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        descriptionLabel.frame = CGRect(x: 100,
                               y: 50,
                               width: contentView.frame.size.width - 115,
                               height: 100)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
    }
}
