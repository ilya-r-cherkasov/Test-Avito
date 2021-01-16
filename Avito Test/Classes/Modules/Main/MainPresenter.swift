//
//  MainPresenter.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 10.01.2021.
//

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    var dataModel: DataModel?
    
    func viewDidLoad() {
        interactor?.fetchDataModel()
    }
    
}
