//
//  SignUpResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/17.
//

import Foundation

struct SignUpResult: Codable {
    var success: Bool?
    var error: NError?
    
    enum CodingKeys: String, CodingKey {
        case success, error
    }
}
