//
//  MainPresenter.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 10.01.2021.
//

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? {get set}
    var dataModel: DataModel? {get set}
    
    func viewDidLoad()
    
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    var dataModel: DataModel?
    
    func viewDidLoad() {
        interactor?.fetchDataModel()
    }
    
}
