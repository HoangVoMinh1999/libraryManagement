//
//  listRulesTableViewCell.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 31/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class listRulesTableViewCell: UITableViewCell {
    @IBOutlet weak var ruletitleLabel: UILabel!
    @IBOutlet weak var contentTextArea: UITextView!
    @IBOutlet weak var readMoreButton: UIButton!
    
    @IBAction func readMoreButton(_ sender: Any) {
        let new_rule:Dictionary<String,Any> = ["title" : ruletitleLabel.text!, "content":contentTextArea.text!]
        temp.set(new_rule, forKey: "current_rule")
    }
    //---
    var temp = UserDefaults()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentTextArea.isEditable = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
