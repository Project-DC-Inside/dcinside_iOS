//
//  SignUpSceneModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/18.
//

import Foundation

class SignUpSceneModel {
    private var signUpInfo = SignUpInfo()
    private var passwordInfo: String? = nil
    
    private var signUpResonable: [Bool] = [Bool](repeating: false, count: 6)
    
    func getSignUpInfo() -> SignUpInfo {
        return signUpInfo
    }
    
    func setId(id: String) {
        signUpInfo.username = id
    }
    
    func setNick(nick: String) {
        signUpInfo.nickname = nick
    }
    
    func setEmail(email: String) {
        signUpInfo.email = email
    }
    
    func setPasswordInfo(password: String) {
        passwordInfo = password
        signUpInfo.password = password
    }
    
    func getPasswordInfo() -> String? {
        guard let text = passwordInfo else { return nil }
        return text
    }
    
    func setSignUpResonable(tag: Int) {
        signUpResonable[tag] = true
    }
    
    func setSignUpNotResonable(tag: Int) {
        signUpResonable[tag] = false
    }
    
    func checkSignUpResonable() -> Bool {
        return signUpResonable[1] && signUpResonable[2] && signUpResonable[3] && signUpResonable[4] && signUpResonable[5]
    }
}
