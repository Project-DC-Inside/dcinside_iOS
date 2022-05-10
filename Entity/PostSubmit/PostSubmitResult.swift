//
//  PostSubmitResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/11.
//

import Foundation

struct PostSubmitResult: Codable {
    let success: Bool
    let result: Int?
    let error: responseError?
}
