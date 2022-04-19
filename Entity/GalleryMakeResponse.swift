//
//  GalleryResult.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation

struct GalleryMakeResponse:Codable {
    let success: Bool
    let result: GalleryMakeResult?
    let error: responseError?
}
