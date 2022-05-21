//
//  GalleryPostListCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/27.
//

import Foundation
import SnapKit
import UIKit

class GalleryPostListCell: UITableViewCell {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
//    private lazy var dataLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 10)
//        label.textColor = .gray
//
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.prepareForReuse()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Gallery Post List Cell Failed!")
    }
    
    
    func configure() {
        let titlesStack = UIStackView()
        
        titlesStack.axis = .vertical
        titlesStack.distribution = .fillProportionally
        
        [title, subTitle].forEach {
            titlesStack.addArrangedSubview($0)
        }
        
        self.addSubview(titlesStack)

        titlesStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.bottom.top.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo((self.frame.height * 2) / 3)
        }
        subTitle.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalTo(title.snp.bottom)
        }
    }
    
    func setLabels(cellInfo: PostInfo) {
        title.text = cellInfo.title
        subTitle.text = "\(cellInfo.nickname) 조회: \(cellInfo.postStatistics.viewCount) 추천 \(cellInfo.postStatistics.likeCount)"
        
    }
}
