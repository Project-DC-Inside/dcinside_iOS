//
//  GalleryNameCells.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation
import SnapKit
import UIKit

class GalleryNameCells: UITableViewCell {
    private lazy var presenter: GalleryNamePresenter? = nil
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 17)
        tf.placeholder = "제목을 입력해 주세요!"
        tf.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .allEditingEvents)
        
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    init(presenter: GalleryNamePresenter) {
        super.init(style: .default, reuseIdentifier: "GalleryNameCells")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Add Cell Error!")
    }
    
    func basicSetting(presenter: GalleryNamePresenter) {
        self.presenter = presenter
        self.presenter?.settings()
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        presenter?.textFieldDidChange(textField: textField)
    }
}

extension GalleryNameCells: GalleryNameProtocol {
    func setViews() {
        contentView.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}
