//
//  SignUpSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/18.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    private lazy var presenter = SignUpScenePresenter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SignUpViewController: SignUpSceneProtocol {
    
}
