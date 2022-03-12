//
//  SignUpResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation

struct SignUpResult: Codable {
    var success: Bool
    var error: NError?
    
    enum CodingKeys: String, CodingKey {
        case success
        case error
    }
}
