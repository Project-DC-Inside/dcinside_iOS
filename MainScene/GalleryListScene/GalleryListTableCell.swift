//
//  galleryListTableCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/20.
//

import Foundation
import SnapKit
import UIKit

class GalleryListTableCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryList Table Cell Error")
    }
    
    private func layout() {
        self.addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func attribute() {
        self.accessoryType = .disclosureIndicator
        
    }
}
