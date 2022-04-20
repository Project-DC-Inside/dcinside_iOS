//
//  PostListTotalResponse.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation

struct PostListTotalResponse: Codable {
    let success: Bool
    var result: [PostInfo]?
    var error: responseError?
}
