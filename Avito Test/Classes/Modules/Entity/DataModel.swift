//
//  DataModel.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 12.01.2021.
//

import Foundation
import UIKit

struct DataModel {
    
    var title: String = ""
//    var image: UIImage {
//    return
//    }
    
    init?(result: Result) {
        self.title = result.result.title
    }
    
}
