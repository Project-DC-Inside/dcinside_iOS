//
//  GalleryTableViewCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/26.
//

import UIKit

class GalleryListTableViewCell: UITableViewCell {

    static let identifier = "GalleryListTableViewCell"
    
    // MARK: - Property
    
    let tableLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    
    // MARK: - configureUI
    
    func configureUI() {
        addSubview(tableLabel)
        
        tableLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
