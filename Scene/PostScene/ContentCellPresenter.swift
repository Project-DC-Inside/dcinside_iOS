//
//  ContentCellPresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/01.
//

import Foundation
import UIKit

protocol ContentCellProtocol: AnyObject {
    func configure()
}

class ContentCellPresenter: NSObject {
    private weak var cell: ContentCellProtocol? = nil
    
    func getCell(cell: ContentCellProtocol?) {
        self.cell = cell
    }
    
    func viewDidLoad() {
        cell?.configure()
    }
}
