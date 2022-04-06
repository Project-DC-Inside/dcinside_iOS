//
//  VisitListSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/20.
//

import Foundation
import UIKit

class VisitListSceneViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("VisitListScene Error")
    }
    
    private func attribute() {
        title = "VisitList"
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        
    }
}
