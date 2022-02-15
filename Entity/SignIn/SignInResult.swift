//
//  SignInResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/15.
//

import Foundation


struct SignInResult: Codable {
    var success: Bool
    var token: Token?
    var error: NError
    
    enum CodingKeys: String, CodingKey {
        case success
        case token = "result"
        case error
    }
}
