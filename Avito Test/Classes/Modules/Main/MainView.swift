//
//  ViewController.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 04.01.2021.
//

import UIKit

protocol MainViewProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }
    var dataGet: DataModel? { get set }
    func showMainView()
    func afterLoadData()
    func ifDataDoesntLoad()
    
}

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
                selectButton.backgroundColor = UIColor(named: "MyBlueColor")
                selectButton.isEnabled = true
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
    
    func showMainView() {

        self.view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.sizeToFit()
        activityIndicator.startAnimating()
        
        //CloseIconTemplate
        imageView.image = UIImage(named: "CloseIconTemplate")
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.sizeToFit()
        
        //selectButton
        selectButton.setTitle("Выбрать", for: .normal)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        selectButton.layer.cornerRadius = 5
        selectButton.addTarget(self, action: #selector(selectItem), for: .touchUpInside)
        selectButton.isEnabled = false
        view.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        selectButton.sizeToFit()
        
    }
    
    func afterLoadData() {
        
        //TitleLabel
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
    }
    
    func ifDataDoesntLoad() {
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        reloadButton.setTitle("Данные не загружены. Перезагрузить?", for: .normal)
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.backgroundColor = UIColor(red: 0.5, green: 0.1, blue: 0.1, alpha: 0.6)
        reloadButton.layer.cornerRadius = 5
        reloadButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        view.addSubview(reloadButton)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //reloadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        reloadButton.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 15).isActive = true
        reloadButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        reloadButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        reloadButton.sizeToFit()
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
            cell?.data?.checkMarkIsHidden = true
            data?.list[indexPath.row].checkMarkIsHidden = true
            indexOfSelectedService = nil
            
        } else {
            
            cell?.data?.checkMarkIsHidden = false
            data?.list[indexPath.row].checkMarkIsHidden = false
            indexOfSelectedService = indexPath.row
            print("didSelectItemAt")
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        cell?.data?.checkMarkIsHidden = true
        data?.list[indexPath.row].checkMarkIsHidden = true
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
    
    @objc func reloadData() {
        
        selectButton.isEnabled = false
        selectButton.isHidden = false
        presenter?.interactor?.fetchDataModel()
    }
    
}
    
