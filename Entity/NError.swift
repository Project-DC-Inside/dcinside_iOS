//
//  NError.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/15.
//

import Foundation

struct NError: Codable {
    var message: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case code
    }
}
