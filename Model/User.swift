//
//  User.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/02.
//

import Foundation

struct User: Codable {
    var ID: String?
    var nickName: String?
    var password: String?
    var email: String?
    var role: Role
}
