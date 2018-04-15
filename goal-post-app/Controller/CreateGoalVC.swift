//
//  CreateGoalVC.swift
//  goal-post-app
//
//  Created by Patrik Kemeny on 15/4/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate { // UITextViewDelegate is here bc the didBeginEditin for clear the textView when start to type

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        goalTextView.delegate = self
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        

        
    }
    

    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
   
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeselectedColor()
        longTermBtn.setSelectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        //i nitialize the data and sedn to another VC
        if goalTextView.text != "" &&  goalTextView.text != "What is your Goal?" {
            guard let finishedGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
            
            finishedGoalVC.initData(description: goalTextView.text!, type: goalType)
            //we sent the data fropm this VC to anotherVC
            presentDetail(finishedGoalVC)
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismisDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
