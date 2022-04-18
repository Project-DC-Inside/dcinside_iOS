//
//  APIResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/18.
//

import Foundation

struct SignInResponse: Codable {
    let success: Bool
    let result: SignInResult?
    let error: responseError?
}
