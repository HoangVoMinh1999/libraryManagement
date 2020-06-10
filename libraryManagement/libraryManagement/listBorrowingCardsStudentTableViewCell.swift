//
//  listBorrowingCardsStudentTableViewCell.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class listBorrowingCardsStudentTableViewCell: UITableViewCell {
    //---Outlet
    @IBOutlet weak var IDcardLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
