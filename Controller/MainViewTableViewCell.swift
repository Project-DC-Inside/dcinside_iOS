//
//  MainViewTableViewCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/12.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {

    @IBOutlet weak var mianTableThumbnail: UIImageView!
    @IBOutlet weak var mainTableTitleLabel: UILabel!
    @IBOutlet weak var mainTableDescriptLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
