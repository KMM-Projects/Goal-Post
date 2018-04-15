//
//  FinishGoalVC.swift
//  goal-post-app
//
//  Created by Patrik Kemeny on 15/4/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit
import CoreData


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
        //pass data to CoreData model
        if pointsTextField.text != "" {
        self.save { (complete) in
            if complete {
                dismiss(animated: true, completion: nil) //dismiss everything to the main controleer
            }
        }
      }
        
    }
    
    @IBAction func backbtnWasPressed(_ sender: Any) {
        dismisDetail()
    }
    
    //CoreData
    
    //save data with response (completion handler)
    func save(completion:(_ finished: Bool) ->() ) {
        //if finished succesfully dismiss VC if some error show error
        //check AppDelegate file - the system make for us their self a saveContext() func etc....
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return} //main queqe from manageContext
        //create instance of goal
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0) //in beginig we have 0 progress
        do {
            try managedContext.save() //bc throws
            //if saving properly
            print("succesfully saved data")
            completion(true)
        } catch {
            //if there is an error
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
        
        
        
        
    }
    
    
}
