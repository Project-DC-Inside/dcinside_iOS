//
//  SideMenuCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/12.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SideMenuCell : UITableViewCell {
    let disposeBag = DisposeBag()
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SideMenuCell Error Occured")
    }
    
    private func attribute() {
        self.backgroundColor = UIColor.systemGray6
        
        titleLabel.textAlignment = .left
    }
    
    private func layout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
