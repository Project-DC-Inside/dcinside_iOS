//
//  PostListResponse.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation

struct PostInfo: Codable {
    let id: Int
    let nickName: String
    let title: String
    let createdAt: String
    let updatedAt: String
    let postStatistics: [PostStatistics]
    let writer: WriterInfo
    let content: String
}

struct WriterInfo: Codable {
    let memberType: String
    let nickname: String
    let username: String
}

struct PostStatistics: Codable {
    let viewCount: Int
    let likeCount: Int
    let dislikeCount: Int
    let commentCount: Int
}
