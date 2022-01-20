//
//  OptionsTableViewCell.swift
//  Radius Agent
//
//  Created by Karthi CK on 20/01/22.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var optionsImageView: UIImageView!
    @IBOutlet weak var optionsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
