//
//  SignUpScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/18.
//

import Foundation
import UIKit

typealias LabelTextwithColor = (Contents: String, Color: UIColor)

protocol SignUpSceneProtocol: AnyObject {
    func setUpViews()
    func idChecker(labelInfo: LabelTextwithColor)
    func nickNameChecker(labelInfo: LabelTextwithColor)
    func pwChecker(labelInfo: LabelTextwithColor)
    func emailChecker(labelInfo: LabelTextwithColor)
}

class SignUpScenePresenter: NSObject {
    private weak var viewController: SignUpSceneProtocol?
    private var passwordInfo: String? = nil
    private var signUpSceneModel = SignUpSceneModel()
    
    init(viewController: SignUpSceneProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setUpViews()
    }
    
    
}

extension SignUpScenePresenter: UITextFieldDelegate {
    
}

extension SignUpScenePresenter {
    func textFieldDidChange(textField: UITextField) {
        // Todo: 텍스트필드 이벤트 반영하기!
        guard let text = textField.text else { return }
        let tag = textField.tag
        
        switch tag {
        case 1: // ID부분
            viewController?.idChecker(labelInfo: idChecker(id: text))
        case 2: // 닉네임
            viewController?.nickNameChecker(labelInfo: nickNameChecker(nickName: text))
        case 3:
            signUpSceneModel.setPasswordInfo(password: text)
        case 4:
            guard let pw = signUpSceneModel.getPasswordInfo() else { return }
            viewController?.pwChecker(labelInfo: passwordChecker(pass: pw, repass: text))
        case 5:
            viewController?.emailChecker(labelInfo: isValidEmail(email: text))
        default:
            print("DEFAULT")
        }
    }
    
    func idChecker(id: String) -> LabelTextwithColor {
        switch id.count {
        case 0...0:
            signUpSceneModel.setSignUpNotResonable(tag: 1)
            return ("5자 ~ 20자 영문, 숫자로 입력해주세요.", .gray)
        case 1...4:
            signUpSceneModel.setSignUpNotResonable(tag: 1)
            return ("ID가 너무 짧습니다.", .red)
        case 5...20:
            signUpSceneModel.setSignUpResonable(tag: 1)
            return ("적절합니다!", .blue)
        default:
            signUpSceneModel.setSignUpNotResonable(tag: 1)
            return ("너무 길어요!", .red)
        }
    }
    
    func nickNameChecker(nickName: String) -> LabelTextwithColor {
        switch nickName.count {
        case 0...0:
            signUpSceneModel.setSignUpNotResonable(tag: 2)
            return ("20자 내외로 닉네임 입력해주세요! :)", .gray)
        case 1...20:
            signUpSceneModel.setSignUpResonable(tag: 2)
            return ("적절합니다!", .blue)
        default:
            signUpSceneModel.setSignUpNotResonable(tag: 2)
            return ("너무 길어요!", .red)
        }
    }
    
    func passwordChecker(pass: String, repass: String) -> LabelTextwithColor{
        if pass.count == 0 || repass.count == 0 {
            signUpSceneModel.setSignUpNotResonable(tag: 3)
            signUpSceneModel.setSignUpNotResonable(tag: 4)
            return ("영문, 숫자 8~20자 내외로 해주세요", .gray)
        }
        if pass.count < 8 || repass.count < 8 {
            signUpSceneModel.setSignUpNotResonable(tag: 3)
            signUpSceneModel.setSignUpNotResonable(tag: 4)
            return ("문자가 너무 적어요!", .red)
        }
        if pass.count > 20 || repass.count > 20 {
            signUpSceneModel.setSignUpNotResonable(tag: 3)
            signUpSceneModel.setSignUpNotResonable(tag: 4)
            return ("문자가 너무 많아요!", .red)
        }
        if pass != repass { return ("비밀번호가 불일치합니다.", .red)}
        let passwordreg = ("(?=.*[A-Za-z])(?=.*[0-9]).{8,20}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        signUpSceneModel.setSignUpResonable(tag: 3)
        signUpSceneModel.setSignUpResonable(tag: 4)
        return passwordtesting.evaluate(with: pass) && passwordtesting.evaluate(with: repass) ? ("적당한 비밀번호입니다!", .blue) : ("영어, 숫자를 섞어주세요!", .red)
        
    }
    
    func isValidEmail(email: String) -> LabelTextwithColor {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailValid.evaluate(with: email) {
            signUpSceneModel.setSignUpResonable(tag: 5)
            return ("이메일이 유효합니다!", .blue)
        }
        else {
            signUpSceneModel.setSignUpNotResonable(tag: 5)
            return ("이메일이 유효하지 않아요.", .red)
        }
    }
}
