//
//  TitleTextFieldPresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/10.
//

import Foundation

protocol TitleTextFieldProtocol: AnyObject {
    func setLayout()
    func setPlaceHolder(placeholder: String)
    func setSecretText()
    func getTitle() -> String
    func setText(text: String)
}

class TitleTextFieldPresenter {
    private weak var viewController: TitleTextFieldProtocol? = nil
    
    init() {
        
    }
    
    func setViewController(viewController: TitleTextFieldProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setLayout()
        }
    }
    
    func setPlaceHolder(placeholder: String) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setPlaceHolder(placeholder: placeholder)
        }
    }
    
    func setSecretText() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setSecretText()
        }
    }
    
    func getTitle() -> String? {
        return viewController?.getTitle()
    }
    
    func setText(text: String) {
        viewController?.setText(text: text)
    }
}
