//
//  ModifyingUnSignedEntity.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/22.
//

import Foundation
struct ModifyingUnSignedEntity: Codable {
    let title: String
    let content: String
}

struct ModifyingUnSignedEntityResponse: Codable {
    let success: Bool
    let result: Int?
    let error: responseError?
}
