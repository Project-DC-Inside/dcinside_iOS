//
//  UnsignedPostPasswordChecker.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/22.
//

import Foundation

struct UnsignedPostPasswordChecker: Codable {
    let postId: Int
    let password: String
}


struct UnsignedPostPasswordResponse: Codable {
    let success: Bool
    let result: Bool?
    let error: responseError?
}
