//
//  Post.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/05.
//

import Foundation

struct Post:Codable {
    var title: String
    var writer: User
    var postHits: Int
    var recommandHits: Int
    var date: Date //임시..
    //var content:
}
