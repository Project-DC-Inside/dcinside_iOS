//
//  AddGalleryModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/22.
//

import Foundation

struct AddGalleryModel {
    func setAlert(action: Result<GalleryResult, NetworkError>)-> Alert {
        switch action {
        case .success(let message):
            return (title: "성공", message: message.result?.name ?? "" + " 성공!")
        default:
            return (title: "실퓨ㅐ", message: "가입 실패!")
        }
    }
    
}
