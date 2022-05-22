//
//  ModifyingSignedEntity.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/22.
//

import Foundation

struct ModifyingSignedEntity: Codable {
    let title: String
    let content: String
}

struct ModifyingSignedEntityResponse: Codable {
    let success: Bool
    let result: Int?
    let error: responseError?
}
