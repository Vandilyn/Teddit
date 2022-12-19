//
//  PostTableViewCell.swift
//  newTeddit
//
//  Created by prk on 18/12/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var judulPost: UILabel!
    @IBOutlet weak var authorName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
