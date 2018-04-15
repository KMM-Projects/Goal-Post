//
//  ViewController.swift
//  goal-post-app
//
//  Created by Patrik Kemeny on 15/4/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit
import CoreData

//constant accesible all around the aplication bc it is not inside the class
let appDelegate =  UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var goals:[Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }
 //when appearing the View make the fetch and show or not show tableView
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObject()
        tableView.reloadData()
    }
  
    func fetchCoreDataObject(){
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 { //it there was saved at least one goal
                    tableView.isHidden = false
                    
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addBoalBtnWasPressed(_ sender: Any) {
        // we wana use segue manual for transition to crateGoalVC
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        //if no VC with this indentifier than just return
        presentDetail(createGoalVC)
    }
}
// we can Comform the Table View up in main Class but this way we are holding everything in One pack just Table View.

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        
        let goal = goals[indexPath.row]
        
        //if we get a cell cast it as GoalCell if not than return an empty UICell
        cell.configureCell(goal: goal)
        return cell
    }
    //for swiping to sides
    //for editing table view
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true //now we can edit tableview
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none //dont show anything special.
    }
    //action for tableview ( one for delete and one for add)
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            //here are doing the staff when deleting
            self.removeGoal(atIndexPath: indexPath) //now removed and saved it
            self.fetchCoreDataObject()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            //here we are seting the progress
            self.setProgress( atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
         return [deleteAction,addAction]
    }
   
}

extension GoalsVC {
    
    //functions allowing as the progress
    func setProgress( atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {return}
        do {
            try managedContext.save()
            print("uccesfully Set Progress!")
        } catch {
            debugPrint("Could Not Set progress\(error.localizedDescription)")
            
        }
    }
    
    //remoce data from coredata model
    
    func removeGoal(atIndexPath indexPath: IndexPath){
        //reference to managecontext
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[indexPath.row]) // find the item and delete
        do {
            try managedContext.save()
            print("Succesfully Removed Goal!")
        } catch{
            debugPrint("could not remove: \(error.localizedDescription)")
        }
        
        
        
    }
    
    //fecth coredata data
    func fetch(completion: (_ complete:Bool) ->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return} //asuming that we have our managed context object
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal") //now we know that we are trying to fecth this particular entity
        do {
            goals =  try managedContext.fetch(fetchRequest) as! [Goal]
            print("succesfully fetched data")
            completion(true)
            } catch {
                debugPrint("Could not tech \(error.localizedDescription)")
                completion(false)
            
        }
    }
    
    
    
}

















