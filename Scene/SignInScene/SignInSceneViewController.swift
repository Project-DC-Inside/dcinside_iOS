//
//  SignInSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/17.
//

import Foundation
import UIKit

class SignInSceneViewController: UIViewController {
    private lazy var presenter = SignInPresenter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension SignInSceneViewController: SignInSceneProtocol {
    
}
