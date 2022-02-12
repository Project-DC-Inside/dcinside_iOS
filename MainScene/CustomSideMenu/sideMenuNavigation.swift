//
//  sideMenuNavigation.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/12.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SideMenu

class SideMenuNavigation: SideMenuNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.presentationStyle = .menuSlideIn
        self.menuWidth = self.view.frame.width * 0.5
        self.leftSide = true
    }
}
