//
//  Networking.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 05.01.2021.
//

import Foundation
struct NetworkManager {
    func fetchResult(completitonHandler: @escaping (DataModel) -> Void ) {
        
        let urlString = "https://raw.githubusercontent.com/avito-tech/internship/main/result.json"
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let dataModel = self.parseJSON(withData: data) {
                    completitonHandler(dataModel)
                }
            }
        }
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
