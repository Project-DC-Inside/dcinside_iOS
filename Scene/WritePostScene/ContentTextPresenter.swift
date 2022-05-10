//
//  ContentTextPresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/10.
//

import Foundation
import UIKit

protocol ContentTextProtocol: AnyObject {
    func configure()
    func getFrame() -> CGRect
    func getContent() -> String
}

class ContentTextPresenter: NSObject {
    private weak var viewController: ContentTextProtocol? = nil
    
    override init() {
        super.init()
    }
    
    func setViewController(viewController: ContentTextProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.configure()
        }
    }
    
    func getFrame() -> CGRect {
        let frame = viewController?.getFrame() ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        print(frame)
        return frame
    }
    
    func getContent() -> String {
        return viewController?.getContent() ?? "textView 에러!"
    }
    
}
