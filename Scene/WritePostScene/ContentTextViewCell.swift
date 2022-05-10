//
//  ContentTextViewCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/10.
//

import Foundation
import UIKit

class ContentTextViewCell: UITableViewCell {
    private lazy var presenter: ContentTextPresenter? = nil
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 20)
        tv.text = "HELLO"
        tv.isEditable = true
        tv.isScrollEnabled = true
        
        return tv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ContentTextViewCell Error")
    }
    
    func viewDidLoad(presenter: ContentTextPresenter) {
        self.presenter = presenter
        self.presenter?.viewDidLoad()
    }
}

extension ContentTextViewCell: ContentTextProtocol {
    func configure() {
        self.addSubview(textView)
        
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let CGF: CGFloat = 360
        let height = CGF < estimatedSize.height ? estimatedSize.height: CGF
        textView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(height)
        }
    }
    
    func getFrame() -> CGRect {
        return self.frame
    }
    
    func getContent() -> String {
        return textView.text
    }
}

