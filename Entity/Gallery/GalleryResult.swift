//
//  GalleryResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/23.
//

import Foundation

struct GalleryResult: Codable {
    var success: Bool?
    var result: Gallery?
    var error: NError?
    
    enum CodingKeys: String, CodingKey {
        case success, result, error
    }
}
