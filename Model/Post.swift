//
//  Post.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/05.
//

import Foundation

struct Post:Codable {
    var title: String
    var nickname: User
    var postHits: Int
    var recommandHits: Int
    var date: String //임시..
    //var content:
}
