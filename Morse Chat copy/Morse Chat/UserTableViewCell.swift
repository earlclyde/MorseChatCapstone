//
//  UserTableViewCell.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/26/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import Foundation
import CloudKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
   // var user = User()
    
    func updateWithUser(user: User) {
//        self.userImageView.layer.masksToBounds = true
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
