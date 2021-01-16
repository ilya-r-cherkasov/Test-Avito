//
//  DataModel.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 12.01.2021.
//

import Foundation
import UIKit

struct DataModel {
    
    var title: String
    var list: [ListCell] = []
    
    init?(result: Result) {
        
        self.title = result.result.title
        for i in result.result.list {
            
            DispatchQueue.main.sync {
                
                let imageView = UIImageView()
                guard let url = URL(string: i.icon.the52X52), let data = try? Data(contentsOf: url) else { return }
                imageView.image = UIImage(data: data)
                if i.isSelected == true {
                    
                    self.list.append(ListCell(title: i.title, price: i.price, listDescription: i.listDescription, iconString: i.icon.the52X52, icon: imageView))
                }
            }
        }
    }
}

struct ListCell {
    
    let title, price: String
    let listDescription: String?
    let iconString: String
    var checkMarkIsHidden = true
    var icon: UIImageView
}
