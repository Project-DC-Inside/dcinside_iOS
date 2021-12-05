//
//  MainTableViewCell.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/05.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
