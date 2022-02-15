//
//  Token.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import Foundation

struct Token: Codable {
    var token:String
    var refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case token = "accessToken"
        case refreshToken
    }
}
