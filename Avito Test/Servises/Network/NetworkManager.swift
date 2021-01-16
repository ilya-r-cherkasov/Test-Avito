//
//  Networking.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 05.01.2021.
//

import Foundation
struct NetworkManager {
    
    private let fileManager = FileManager.default

    enum MyError: Error {
        case DataIsNil
    }

    func fetchResult(completitonHandler: @escaping (DataModel?, Error?) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/avito-tech/internship/main/result.json")!
        let session = URLSession.shared
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15.0)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            do {
                if let error = error {
                    completitonHandler(nil, error)
                } else {
                    guard let data = self.parseJSON(withData: data!) else {
                        throw MyError.DataIsNil
                    }
                    completitonHandler(data, nil)
                }
            } catch let blockError {
                print(blockError)
            }
        })
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> DataModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(Result.self, from: data)
            guard let dataModel = DataModel(result: result) else {
                return nil
            }
            return dataModel
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
