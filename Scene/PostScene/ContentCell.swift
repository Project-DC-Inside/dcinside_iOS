//
//  ContentCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/28.
//

import Foundation
import UIKit

class ContentCell: UITableViewCell {
    private lazy var presenter = ContentCellPresenter()
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.font = .systemFont(ofSize: 20)
        
        return tv
    }()
    private let content: String
    
    init(content: String) {
        self.content = content
        super.init(style: .default, reuseIdentifier: nil)
        presenter.getCell(cell: self)
        presenter.viewDidLoad()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("ContentCellE")
    }
}

extension ContentCell: ContentCellProtocol {
    func configure() {
        self.addSubview(textView)
        textView.text = content
        
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let CGF: CGFloat = 180
        let height = CGF < estimatedSize.height ? estimatedSize.height: CGF
        textView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(height)
        }
    }
}
extension ContentCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { constraint in
            if estimatedSize.height <= 180 {
                
            } else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
