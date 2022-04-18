//
//  SignUpResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/18.
//

import Foundation

struct SignUpResponse: Codable {
    let success: Bool
    let error: responseError?
}
