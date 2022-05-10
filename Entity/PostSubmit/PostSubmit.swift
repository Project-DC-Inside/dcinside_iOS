//
//  PostSubmit.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/11.
//

import Foundation

struct PostSubmitLogIn: Codable {
    let galleryId: Int
    let title: String
    let content: String
    
    init(galleryId: Int, title: String, content: String) {
        self.galleryId = galleryId
        self.title = title
        self.content = content
    }
}

struct PostSubmitLogOff: Codable {
    let galleryId: Int
    let title: String
    let content: String
    let nickname: String
    let password: String
    
    init(galleryId: Int, title: String, nickname: String, password: String, content: String) {
        self.galleryId = galleryId
        self.title = title
        self.nickname = nickname
        self.password = password
        self.content = content
    }
}
