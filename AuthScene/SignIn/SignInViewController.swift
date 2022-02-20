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
    let signUpButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignIn Scene Error")
    }
    
    func bind(_ viewModel: SignInViewModel) {
        
        viewModel.nextCheck
            .drive(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.errorCheck
            .emit(to: self.rx.setAlert)
            .disposed(by: disposeBag)
        
        viewModel.signUp
            .drive(onNext: {
                let nextScene = SignUpViewController()
                //nextScene.bind(viewModel: SignUpViewModel())
                self.navigationController?.pushViewController(nextScene, animated: true)
            }).disposed(by: disposeBag)
        
        idTextView.rx.text
            .bind(to: viewModel.idInfo)
            .disposed(by: disposeBag)
        
        pwTextView.rx.text
            .bind(to: viewModel.pwInfo)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind(to: viewModel.submitButtonTapped)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind(to: viewModel.signUpButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "SignIn"
        view.backgroundColor = .systemBackground
        
        idTextView.borderStyle = .roundedRect
        idTextView.placeholder = "아이디"
        
        pwTextView.borderStyle = .roundedRect
        pwTextView.placeholder = "비밀번호"
        pwTextView.isSecureTextEntry = true
        
        submitButton.setTitle("로그인", for: .normal)
        submitButton.backgroundColor = .systemBlue
        
        signUpButton.setTitle("회원 가입", for: .normal)
        signUpButton.setTitleColor(.systemGray, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    private func layout() {
        view.addSubview(idTextView)
        view.addSubview(pwTextView)
        view.addSubview(submitButton)
        view.addSubview(signUpButton)
        
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
    
}


typealias Alert = (title: String, message: String?)
extension Reactive where Base:SignInViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let alert = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(alert)
            base.present(alertController, animated: true, completion: nil)
        }
    }
}


