//
//  Gallery.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation

struct Gallery : Codable {
    var type: String
    var name: String
    enum CodingKeys: String, CodingKey {
        case type, name
    }
}

