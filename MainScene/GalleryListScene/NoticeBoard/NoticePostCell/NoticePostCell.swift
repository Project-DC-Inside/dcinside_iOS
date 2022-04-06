//
//  NoticePostCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation
import SnapKit
import UIKit
import RxSwift
import RxCocoa

class NoticePostCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Notice Post Cell Error Occured")
    }
    
    private func layout() {
        self.addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    private func attribute() {
        label.font = UIFont.systemFont(ofSize: 15)
    }
    
    func bind() {
        
    }
}
