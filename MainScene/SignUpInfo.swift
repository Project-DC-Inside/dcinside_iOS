//
//  SignUpInfo.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation

struct SignUpInfo: Codable {
    var username: String
    var password: String
    var email: String
    var nickname: String
    var nicknameType: String = "COMMON"
    
    init(id: String, password: String, email: String, nickName: String) {
        self.username = id
        self.password = password
        self.email = email
        self.nickname = nickName
    }
    enum CodingKeys: String, CodingKey {
        case username, password, email, nickname, nicknameType
    }
}
