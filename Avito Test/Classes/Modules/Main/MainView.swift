//
//  ViewController.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 04.01.2021.
//

import UIKit

class MainView: UIViewController, MainViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: MainPresenterProtocol?
    private var collectionView: UICollectionView?
    var indexOfSelectedService: Int?
    let activityIndicator = UIActivityIndicatorView()
    let imageView = UIImageView()
    let selectButton = UIButton()
    let reloadButton = UIButton()
    let titleLabel = UILabel()
    var data: DataModel?
    var dataGet: DataModel? {
        get {
            return nil
        } set {
            if (newValue != nil) && (newValue?.list.count != 0) {
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
                data = newValue
                reloadButton.isEnabled = false
                reloadButton.isHidden = true
                afterLoadData()
            }
        }
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.createMainViewModule(mainViewRef: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - MainViewProtocol methods
    func showMainView() {
        
        self.view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.sizeToFit()
        activityIndicator.startAnimating()
        
        view.addSubview(imageView)
        imageView.image = UIImage(named: "CloseIconTemplate")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.sizeToFit()
        
        view.addSubview(selectButton)
        selectButton.setTitle("Выбрать", for: .normal)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        selectButton.layer.cornerRadius = 5
        selectButton.addTarget(self, action: #selector(selectItem), for: .touchUpInside)
        selectButton.isEnabled = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        selectButton.sizeToFit()
        
        view.addSubview(reloadButton)
        reloadButton.setTitle("Данные не загружены. Перезагрузить?", for: .normal)
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.backgroundColor = UIColor(red: 0.5, green: 0.1, blue: 0.1, alpha: 0.6)
        reloadButton.layer.cornerRadius = 5
        reloadButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        reloadButton.isHidden = true
        reloadButton.isEnabled = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        reloadButton.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 15).isActive = true
        reloadButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        reloadButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        reloadButton.sizeToFit()
        
    }
    
    func afterLoadData() {
        
        view.addSubview(titleLabel)
        titleLabel.text = data?.title
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        titleLabel.sizeToFit()
        
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -15).isActive = true
        collectionView.backgroundColor = .white
        collectionView.sizeToFit()
    }
    
    func ifDataDoesntLoad() {
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        reloadButton.isHidden = false
        reloadButton.isEnabled = true
    }
    
    // MARK: - CollectionView delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if data != nil {
            return (data?.list.count)!
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.indentifier, for: indexPath) as! CustomCollectionViewCell
        cell.data = self.data?.list[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        
        if indexOfSelectedService == indexPath.row {
            cell?.data?.checkMarkIsHidden = true
            data?.list[indexPath.row].checkMarkIsHidden = true
            selectButton.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
            selectButton.isEnabled = false
            indexOfSelectedService = nil
        } else {
            
            cell?.data?.checkMarkIsHidden = false
            data?.list[indexPath.row].checkMarkIsHidden = false
            indexOfSelectedService = indexPath.row
            selectButton.backgroundColor = UIColor(named: "MyBlueColor")
            selectButton.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        
        cell?.data?.checkMarkIsHidden = true
        data?.list[indexPath.row].checkMarkIsHidden = true
        indexOfSelectedService = indexPath.row
        selectButton.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        selectButton.isEnabled = false
    }
    
    // MARK: - Action methods
    @objc func selectItem() {
        
            let alert = UIAlertController(title: data?.list[indexOfSelectedService!].title, message: data?.list[indexOfSelectedService!].listDescription, preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defaul action"), style: .default, handler: { _ in
                NSLog("Оповещение \"Услуга выбрана\"")
            }))
            self.present(alert, animated: true, completion: nil)
    }
    
    @objc func reloadData() {
        
        reloadButton.isEnabled = false
        presenter?.interactor?.fetchDataModel()
    }
}

