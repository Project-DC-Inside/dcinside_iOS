//
//  PostListRequest.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation

struct PostListRequest: Codable {
    let galleryId: Int
    let lastPostId: Int?
}
