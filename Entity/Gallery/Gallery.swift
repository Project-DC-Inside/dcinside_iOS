//
//  GalleryMake.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/23.
//

import Foundation

struct Gallery : Codable {
    var type: String
    var name: String
    enum CodingKeys: String, CodingKey {
        case type, name
    }
}
