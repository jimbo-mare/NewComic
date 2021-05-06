//
//  CustomCell.swift
//  NewComi
//
//  Created by Ikumi Jimbo on 2021/05/06.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Detail: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
