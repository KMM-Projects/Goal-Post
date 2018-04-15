 //
//  UIViewControllerExt.swift
//  goal-post-app
//
//  Created by Patrik Kemeny on 15/4/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit //UIKit includes foundation
 
 extension UIViewController {
    
    //modifying animation with our own
    
    func presentDetail(_ viewControllerToPressent: UIViewController){ // everything after _ is internal parameter we do not need to set it
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush //kCoreAnimation....
        transition.subtype = kCATransitionFromRight // the transition is from right to the left
        self.view.window?.layer.add(transition, forKey: kCATransition)
        //now we set up our own transition
        present(viewControllerToPressent, animated: false, completion: nil) //we need to type false bc if we type true we are sticking with the basic animation but we already overwrite it above
        
    }
    
    //func from create goal to home VC
    func presentSecondaryDetail(_ viewControllerPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        guard let presentedViewController = presentedViewController else {return} //reference to the now presented viewController
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            //present the viewController we passed in
            self.present(viewControllerPresent, animated: false, completion: nil ) //here the completion doesnt matter
        }
      
    }
    
    // func to dismiss the controller from right to left
    func dismisDetail(){
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
      
        dismiss(animated: false, completion: nil)
    }
    
    
    
 }
 
 
