//
//  TitleTextFieldCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/10.
//

import Foundation
import UIKit
import SnapKit

class TitleTextFieldCell: UITableViewCell {
    private var presenter: TitleTextFieldPresenter? = nil
    private lazy var textField: UITextField = {
        let tf = UITextField()
        
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("TextField Error Occured")
    }
    
    func viewDidLoad(presenter: TitleTextFieldPresenter) {
        self.presenter = presenter
        self.presenter?.viewDidLoad()
    }
}

extension TitleTextFieldCell: TitleTextFieldProtocol {
    func setLayout() {
        self.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
    }
    
    func setPlaceHolder(placeholder: String) {
        textField.placeholder = placeholder
    }
    
    func setSecretText() {
        textField.isSecureTextEntry = true
    }
    
    func getTitle() -> String {
        return textField.text ?? ""
    }
}
