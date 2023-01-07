//
//  CommentTableViewCell.swift
//  newTeddit
//
//  Created by prk on 1/6/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
