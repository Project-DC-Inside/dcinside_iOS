//
//  tokenInfo.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/19.
//

import Foundation

struct tokenInfo: Codable {    
    var accessToken: String
    var accessTokenExpiresIn: Int
    var grantType: String
    var refreshToken : String
}
