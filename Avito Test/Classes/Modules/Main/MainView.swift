//
//  ViewController.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 04.01.2021.
//

import UIKit

protocol MainViewProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }
    func showMainView(with dataModel: DataModel?)
    
}

class MainView: UIViewController, MainViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: MainPresenterProtocol?
    private var collectionView: UICollectionView?
    var indexOfSelectedService: Int?
    var data: DataModel?

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.createMainViewModule(mainViewRef: self)
        presenter?.viewDidLoad()
    }
    
    func showMainView(with dataModel: DataModel?) {
        
        print("showMainView")
        
        self.view.backgroundColor = .white
        data = dataModel
        
        let activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.sizeToFit()
        
        if dataModel?.list != nil {
            
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            
            //CloseIconTemplate
            let imageView = UIImageView()
            imageView.image = UIImage(named: "CloseIconTemplate")
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.sizeToFit()
            
            //TitleLabel
            let titleLabel = UILabel()
            titleLabel.text = data?.title
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
            view.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15).isActive = true
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
            titleLabel.sizeToFit()
            
            //selectButton
            let selectButton = UIButton()
            selectButton.setTitle("Выбрать", for: .normal)
            selectButton.setTitleColor(.white, for: .normal)
            selectButton.backgroundColor = UIColor(named: "MyBlueColor")
            selectButton.layer.cornerRadius = 5
            selectButton.addTarget(self, action: #selector(selectItem), for: .touchUpInside)
            view.addSubview(selectButton)
            selectButton.translatesAutoresizingMaskIntoConstraints = false
            selectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            selectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
            selectButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
            selectButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
            selectButton.sizeToFit()
            
            // CollectionView
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.estimated(44)
            )
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            let layout = UICollectionViewCompositionalLayout(section: section)
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            guard let collectionView = collectionView else {
                return
            }
            collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.indentifier)
            collectionView.dataSource = self
            collectionView.delegate = self
            view.addSubview(collectionView)
            //collectionView.collectionViewLayout.invalidateLayout()
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -15).isActive = true
            collectionView.backgroundColor = .white
            collectionView.sizeToFit()
            
        } else {
            
            activityIndicator.startAnimating()
            
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("numberOfItemsInSection")
        if data != nil {
        return (data?.list.count)!
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.indentifier, for: indexPath) as! CustomCollectionViewCell
        cell.data = self.data?.list[indexPath.row]
        print("cellForItemAt")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        if indexOfSelectedService == indexPath.row {
            cell?.checkMarkDeselected()
            indexOfSelectedService = nil
            
        } else {
            
        cell?.checkMarkSelected()
        indexOfSelectedService = indexPath.row
        print("didSelectItemAt")
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        cell?.checkMarkDeselected()
        indexOfSelectedService = indexPath.row
        print("didDeselectItemAt")
        
    }
    
    // MARK: - Action methods
    @objc func selectItem() {
        
        if indexOfSelectedService != nil {
            
        let alert = UIAlertController(title: data?.list[indexOfSelectedService!].title, message: data?.list[indexOfSelectedService!].listDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defaul action"), style: .default, handler: { _ in
            NSLog("Оповещение \"Услуга выбрана\"")
        }))
        self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Услуга не выбрана", message: "Пожалуйста, выберите услугу", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defaul action"), style: .default, handler: { _ in
                NSLog("Оповещение \"Услуга не выбрана\"")
            }))
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
}
    
