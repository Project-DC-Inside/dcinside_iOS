//
//  GalleryCategory.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/25.
//

import Foundation

struct GalleryCategory:Codable {
    var title: String
    var cells: [GalleryCell]
}


struct GalleryCell:Codable {
    var galleryTitle: String
    var url: String
}
