//
//  MainInteractor.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 10.01.2021.
//

import Foundation

protocol MainInteractorProtocol: class {
    
    var presenter: MainPresenterProtocol? { get set }

    func fetchDataModel()
}

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol?
    
    func fetchDataModel() {

        self.presenter?.view?.showMainView(with: nil)
        
        NetworkManager().fetchResult(completitonHandler: { dataModel in
            
            DispatchQueue.main.async {
                
                self.presenter?.view?.showMainView(with: dataModel)
                
            }
            
        })

    }
    
}
