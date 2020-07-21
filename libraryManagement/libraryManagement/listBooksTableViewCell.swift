//
//  listBooksTableViewCell.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 20/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class listBooksTableViewCell: UITableViewCell {

    @IBOutlet weak var booknameLabel: UILabel!
    @IBOutlet weak var bookIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
