//
//  SignUpInfo.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/16.
//

import Foundation

struct SignUpInfo: Codable {
    var id: String
    var password: String
    var email: String
    var nickName: String
    var nicknameType: String
    
    init(id: String, password: String, email: String, nickName: String) {
        self.id = id
        self.password = password
        self.email = email
        self.nickName = nickName
        self.nicknameType = "COMMON"
    }
    enum CodingKeys: String, CodingKey {
        case id = "username"
        case password, email
        case nickName = "nickname"
        case nicknameType
    }
}
