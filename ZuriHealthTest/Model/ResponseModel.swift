//
//  ResponseModel.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import Foundation

// MARK: - ImageResponseValue
struct ResponseModelValue: Codable {
    let barcode, imageResponseDescription, id: String
    let imageURL: String
    let name: String
    let retailPrice: Int
    let costPrice: Int?

    enum CodingKeys: String, CodingKey {
        case barcode
        case imageResponseDescription = "description"
        case id
        case imageURL = "image_url"
        case name
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
    }
}

typealias ResponseModel = [String: ResponseModelValue]
