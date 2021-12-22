//
//  User.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/02.
//

import Foundation

struct User: Codable {
    var username: String
    var password: String
    var email: String
    var nickname: String
    var nicknameType: String = "COMMON"
}

struct SignUpResponse: Codable {
    var success: Bool?
    var result: String?
    var error: ErrInfo?
}
