//
//  PostResponse.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/01.
//

import Foundation

import Foundation

struct PostResponse: Codable {
    let success: Bool
    var result: PostInfo?
    var error: responseError?
}
