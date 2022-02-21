//
//  AddGalleryModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/22.
//

import Foundation

struct AddGalleryModel {
    func setAlert(errorMessage: [String])-> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil: errorMessage.joined(separator: "\n")
        
        return (title: title, message: message)
    }
}
