//
//  SignInInfo.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/18.
//

import Foundation

struct SignInInfo: Codable {
    let id: String
    let pw: String
    
    enum CodingKeys: String, CodingKey {
        case id = "username"
        case pw = "password"
    }
}
