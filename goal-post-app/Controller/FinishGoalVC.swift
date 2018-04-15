//
//  FinishGoalVC.swift
//  goal-post-app
//
//  Created by Patrik Kemeny on 15/4/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription:String!
    var goalType: GoalType!
    
    
    
    func initData(description: String, type: GoalType){
        self.goalType = type
        self.goalDescription = description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self

       
    }

  
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
    }
    //pass data to core data Model
}
