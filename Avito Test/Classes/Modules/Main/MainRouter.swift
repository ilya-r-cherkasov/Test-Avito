//
//  MainRouter.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 10.01.2021.
//

class MainRouter: MainRouterProtocol {
    
    class func createMainViewModule(mainViewRef: MainView) {
        
        let presenter: MainPresenterProtocol = MainPresenter()
        
        mainViewRef.presenter = presenter
        mainViewRef.presenter?.router = MainRouter()
        mainViewRef.presenter?.view = mainViewRef
        mainViewRef.presenter?.interactor = MainInteractor()
        mainViewRef.presenter?.interactor?.presenter = presenter
    }
}
