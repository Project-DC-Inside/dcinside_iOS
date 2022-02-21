//
//  TitleTextFieldCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/22.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import SnapKit

class TitleTextFieldCell : UITableViewCell {
    let disposeBag = DisposeBag()
    
    let titleIputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("HELLLL")
    }
    
    func bind(_ viewModel: TitleTextFieldCellViewModel) {
        titleIputField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        titleIputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        contentView.addSubview(titleIputField)
        
        titleIputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}

