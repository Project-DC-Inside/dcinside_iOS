//
//  SignUpViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/16.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    let wrappingView = UIView()
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    let idLabel = UILabel()
    let idTextField = UITextField()
    let idConstraint = UILabel()
    
    let nickNameLabel = UILabel()
    let nickNameTextField = UITextField()
    let nickNameConstraint = UILabel()
    
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let rePasswordTextField = UITextField()
    let passwordConstraint = UILabel()
    
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let emailCertiButton = UIButton()
    
    let certiNumb = UITextField()
    let signUpButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignUpViewController Error")
    }
    
    func bind(viewModel: SignUpViewModel) {
        
    }
    
    private func attribute() {
        title = "SignUp"
        view.backgroundColor = .systemBackground
        
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false;
        
        idLabel.text = "아이디"
        idTextField.borderStyle = .roundedRect
        idConstraint.text = "5자 ~ 20자 영문, 숫자로 입력해주세요."
        idConstraint.textColor = UIColor.systemGray
        idConstraint.font = UIFont.systemFont(ofSize: 10)
        
        nickNameLabel.text = "닉네임"
        nickNameTextField.borderStyle = .roundedRect
        nickNameConstraint.text = "20자 내외로 닉네임 입력해주세요!, 띄어쓰기는 안됩니다 :)"
        nickNameConstraint.textColor = UIColor.systemGray
        nickNameConstraint.font = UIFont.systemFont(ofSize: 10)
        
        passwordLabel.text = "비밀번호"
        passwordTextField.borderStyle = .roundedRect
        rePasswordTextField.borderStyle = .roundedRect
        passwordConstraint.text = "영문, 숫자 8~20자 내외로 해주세요"
        passwordConstraint.textColor = UIColor.systemGray
        passwordConstraint.font = UIFont.systemFont(ofSize: 8)
        
        emailLabel.text = "이메일"
        emailTextField.borderStyle = .roundedRect
        emailCertiButton.setTitle("이메일 인증", for: .normal)
        emailCertiButton.backgroundColor = UIColor.systemBlue
        emailCertiButton.titleLabel?.textColor = .white
        emailCertiButton.layer.cornerRadius = 8
        
        certiNumb.placeholder = "인증번호"
        certiNumb.textColor = UIColor.systemGray
        certiNumb.borderStyle = .roundedRect
        certiNumb.isHidden = true
        
        signUpButton.setTitle("가입하기", for: .disabled)
        signUpButton.layer.opacity = 0
        signUpButton.backgroundColor = UIColor.systemBlue
        signUpButton.titleLabel?.textColor = .white
        signUpButton.layer.cornerRadius = 8
    }
    
    private func layout() {
        view.addSubview(scrollView)
                
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(view.frame.width)
            $0.height.equalTo(view.frame.height + 100)
        }
        
        contentView.addSubview(idLabel)
        contentView.addSubview(idTextField)
        contentView.addSubview(idConstraint)
        
        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        idConstraint.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(nickNameTextField)
        contentView.addSubview(nickNameConstraint)
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(idConstraint.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nickNameConstraint.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(rePasswordTextField)
        contentView.addSubview(passwordConstraint)
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameConstraint.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        rePasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordConstraint.snp.makeConstraints {
            $0.top.equalTo(rePasswordTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(emailCertiButton)
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(passwordConstraint.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailCertiButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(certiNumb)
        
        certiNumb.snp.makeConstraints {
            $0.top.equalTo(emailCertiButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(certiNumb.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
