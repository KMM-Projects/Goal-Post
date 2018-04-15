//
//  UIViewExt.swift
//  goal-post-app
//
//  Created by Patrik Kemeny on 15/4/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

extension UIView {
    // bind the Next Button to the popup keyboard
    // everytime when the keyboard opens we need to recieve a notification about his frame change
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame , object: nil) // set up an observer when the cnage occure
        //selector is pointing to function what to do when the change occure
        
        
            
        }
    
    @objc func keyBoardWillChange(_ notifaction: NSNotification){
        let duration = notifaction.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double //duration of keyboard animation
        //all animation have curve of animation
        let curve = notifaction.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notifaction.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue //this capture the location of frame the keyboard before pops up, it tells us where it is
        //and we are converting it to CGrect.
        //so now we have a rectangle of keyboard below the Screen, we do not see it now
        
        // now capture the ending frame, to know the size ehere can go another view/frame (our Next button)
        
        let endingFrame = (notifaction.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //now we know where the frame ends
        
        /// we know now the diference between end and start point
        
        let deltaY = endingFrame.origin.y - startingFrame.origin.y //now we know how much it is moving up
        
        //lets animated
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions.init(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
        
        
    }
    
    
}
