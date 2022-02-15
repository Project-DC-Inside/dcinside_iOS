//
//  LoginInfo.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import Foundation


struct LoginInfo: Codable {
    var id: String
    var pw: String
    enum CodingKeys: String, CodingKey {
        case id = "username"
        case pw = "password"
    }
}
