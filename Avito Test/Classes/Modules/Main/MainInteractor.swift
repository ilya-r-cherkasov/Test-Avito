//
//  MainInteractor.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 10.01.2021.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol?
    
    func fetchDataModel() {

        self.presenter?.view?.showMainView()
        NetworkManager().fetchResult(completitonHandler: { dataModel, error in
            
            DispatchQueue.main.async {
                
                if (error != nil) {
                    self.presenter?.view?.ifDataDoesntLoad()
                } else {
                    if (dataModel != nil) && (dataModel?.list.count != 0) {
                        self.presenter?.view?.dataGet = dataModel
                    }
                }
            }
        })
    }
}
