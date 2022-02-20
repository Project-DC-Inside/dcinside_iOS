//
//  GalleryList.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/20.
//

import Foundation

struct Gallery : Codable {
    var type: String
    var name: String
    enum CodingKeys: String, CodingKey {
        case type, name
    }
}

struct GalleryList: Codable {
    var success: Bool?
    var result: [Gallery]?
    var error: NError?
    
    enum CodingKeys: String, CodingKey {
        case success, result, error
    }
}
