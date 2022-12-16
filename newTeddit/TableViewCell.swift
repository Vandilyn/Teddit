//
//  TableViewCell.swift
//  newTeddit
//
//  Created by prk on 12/15/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var judul: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
