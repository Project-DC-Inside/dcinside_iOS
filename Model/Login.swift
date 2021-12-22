//
//  Login.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/04.
//

import Foundation

struct Login: Codable {
    var username: String
    var password: String
}

struct LoginResponse: Codable {
    var success: Bool?
    var result: TokenInfo?
    var error: ErrInfo?
}
