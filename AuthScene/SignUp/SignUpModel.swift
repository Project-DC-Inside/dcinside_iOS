//
//  SignUpModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/16.
//

import Foundation
import UIKit
// 비즈니스 로직을 처리해주자.

typealias LabelTextwithColor = (String, UIColor)

struct SignUpModel {
    func idChecker(id: String) -> LabelTextwithColor {
        switch id.count {
        case 0...0:
            return ("5자 ~ 20자 영문, 숫자로 입력해주세요.", .gray)
        case 1...4:
            return ("ID가 너무 짧습니다.", .red)
        case 5...20:
            return ("적절합니다!", .blue)
        default:
            return ("너무 길어요!", .red)
        }
    }
    
    func nickNameChecker(nickName: String) -> LabelTextwithColor {
        switch nickName.count {
        case 0...0:
            return ("20자 내외로 닉네임 입력해주세요! :)", .gray)
        case 1...20:
            return ("적절합니다!", .blue)
        default:
            return ("너무 길어요!", .red)
        }
    }
    
    func passwordChecker(pass: String, repass: String) -> LabelTextwithColor{
        if pass.count == 0 || repass.count == 0 {
            return ("영문, 숫자 8~20자 내외로 해주세요", .gray)
        }
        if pass.count < 8 || repass.count < 8 {
            return ("문자가 너무 적어요!", .red)
        }
        if pass.count > 20 || repass.count > 20 {
            return ("문자가 너무 많아요!", .red)
        }
        if pass != repass { return ("비밀번호가 불일치합니다.", .red)}
        let passwordreg = ("(?=.*[A-Za-z])(?=.*[0-9]).{8,20}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: pass) && passwordtesting.evaluate(with: repass) ? ("적당한 비밀번호입니다!", .blue) : ("영어, 숫자를 섞어주세요!", .red)
        
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            
        return emailValid.evaluate(with: email)
    }
}
