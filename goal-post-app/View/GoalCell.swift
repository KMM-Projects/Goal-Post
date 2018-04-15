//
//  GoalCell.swift
//  goal-post-app
//
//  Created by Patrik Kemeny on 15/4/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

  
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(description: String, type: String, goalProgressAmount: Int){
        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type
        self.goalProgressLbl.text = String(describing: goalProgressAmount)
        
    }
    
}
