//
//  SignInSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/17.
//

import Foundation
import SnapKit
import UIKit

class SignInSceneViewController: UIViewController {
    private lazy var presenter = SignInPresenter(viewController: self)
    
    private lazy var idTextView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "이메일을 입력하세요."
        tv.delegate = presenter
        tv.borderStyle = .roundedRect
        
        return tv
    }()
    
    private lazy var pwTextView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "비밀번호를 입력하세요"
        tv.delegate = presenter
        tv.borderStyle = .roundedRect
        
        return tv
    }()
    
    private lazy var submitButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(didTappedSubmitButton), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(didTappedSignUpButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension SignInSceneViewController: SignInSceneProtocol {
    func setUpViews() {
        [idTextView, pwTextView, submitButton, signUpButton].forEach {
            view.addSubview($0)
        }
        
        idTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(view.frame.height / 20)
        }
        
        pwTextView.snp.makeConstraints {
            $0.top.equalTo(idTextView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(view.frame.height / 20)
        }
        
        submitButton.snp.makeConstraints {
            $0.top.equalTo(pwTextView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(submitButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
    }
    
    func popScene() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func signUp() {
        let vc = SignUpSceneViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignInSceneViewController {
    @objc func didTappedSubmitButton() {
        guard let id = idTextView.text else { return }
        guard let pw = pwTextView.text else { return }
        presenter.didTappedSubmitButton(id: id, pw: pw)
    }
    
    @objc func didTappedSignUpButton() {
        presenter.didTappedSignUpButton()
    }
}
