//
//  Result.swift
//  Avito Test
//
//  Created by Ilya Cherkasov on 05.01.2021.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let status: String
    let result: ResultClass
}

// MARK: - ResultClass
struct ResultClass: Codable {
    let title, actionTitle, selectedActionTitle: String
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let id, title: String
    let listDescription: String?
    let icon: Icon
    let price: String
    let isSelected: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case listDescription = "description"
        case icon, price, isSelected
    }
}

// MARK: - Icon
struct Icon: Codable {
    let the52X52: String

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
