//
//  MainProtocol.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 10.01.2021.
//

protocol MainRouterProtocol: class {

    static func createMainViewModule(mainViewRef: MainView)
}

protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }

    func fetchDataModel()
}

protocol MainPresenterProtocol: class {
    
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var router: MainRouterProtocol? {get set}
    var dataModel: DataModel? {get set}
    
    func viewDidLoad()
}

protocol MainViewProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }
    var dataGet: DataModel? { get set }
    
    func showMainView()
    func afterLoadData()
    func ifDataDoesntLoad()
}
