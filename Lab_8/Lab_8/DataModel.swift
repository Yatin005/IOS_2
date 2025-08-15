//
//  Datamodel.swift
//  Lab_8
//
//  Created by Yatin Parulkar on 2025-08-15.
//

import Foundation

import Foundation

struct DataModel: Identifiable, Codable {
    let id: String        
    let name: String
    let imageurl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageurl
    }
}

