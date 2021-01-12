//
//  Networking.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 05.01.2021.
//

import Foundation
struct Networking {
    func fetchResult(){
        
        let urlString = "https://raw.githubusercontent.com/avito-tech/internship/main/result.json"
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, response, error in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(Result.self, from: data)
            print(result.status)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
