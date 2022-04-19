//
//  GalleryName.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation
import UIKit

protocol GalleryNameProtocol: AnyObject {
    func setViews()
}

class GalleryNamePresenter: NSObject {
    private weak var tableViewCell: GalleryNameProtocol?
    private var contents: String?
    
    init(tableViewCell: GalleryNameProtocol) {
        self.tableViewCell = tableViewCell
    }
    
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        contents = text
    }
    
    func settings() {
        tableViewCell?.setViews()
    }
    
    func getContents() -> String? {
        return contents
    }
}
