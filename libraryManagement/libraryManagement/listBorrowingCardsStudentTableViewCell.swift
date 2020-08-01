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
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    @IBOutlet weak var startedDayLabel: UILabel!
    
    @IBOutlet weak var endedDayLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImageView.layer.borderColor = UIColor(red:0 , green:0, blue:0, alpha: 1).cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
