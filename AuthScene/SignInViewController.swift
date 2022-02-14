//
//  SignInViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SignInViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let idTextView = UITextField()
    let pwTextView = UITextField()
    
    let submitButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignIn Scene Error")
    }
    
    func bind(_ viewModel: SignInViewModel) {
        
        viewModel.requestData
            .drive(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        idTextView.rx.text
            .bind(to: viewModel.idInfo)
            .disposed(by: disposeBag)
        
        pwTextView.rx.text
            .bind(to: viewModel.pwInfo)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind(to: viewModel.submitButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "SignIn"
        view.backgroundColor = .systemBackground
        
        idTextView.layer.cornerRadius = 5
        idTextView.layer.borderWidth = 0.5
        idTextView.placeholder = "아이디"
        
        pwTextView.layer.cornerRadius = 5
        pwTextView.layer.borderWidth = 0.5
        pwTextView.placeholder = "비밀번호"
        pwTextView.isSecureTextEntry = true
        
        submitButton.setTitle("로그인", for: .normal)
        submitButton.backgroundColor = .systemBlue
    }
    
    private func layout() {
        view.addSubview(idTextView)
        view.addSubview(pwTextView)
        view.addSubview(submitButton)
        
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
    }
    
}
