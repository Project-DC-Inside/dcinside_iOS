//
//  SignInModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/16.
//

import Foundation

struct SignInModel {
    func setAlert(action: SignInAction) -> Alert {
        switch action {
        case .nonExist:
            return (title: "로그인 실패", message: "존재하지 않는 아이디")
        case .networkErr:
            return (title: "로그인 실패", message: "네트워크 에러")
        default:
            return (title: "로그인 실패", message: "원인 불명")
        }
    }
}
