//
//  Utils.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/07.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import Foundation
import UIKit

var aiView : UIView?

extension UIViewController {
    
    func showSpinner() {
        
        //Makes sure view is at 0,0
        aiView = UIView(frame: self.view.bounds)
        
        aiView?.backgroundColor = UIColor.white
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = aiView!.center
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        aiView?.addSubview(activityIndicator)
        self.view.addSubview(aiView!)
        
    }
    
    func removeSpinner() {
        aiView?.removeFromSuperview()
        aiView = nil
        
    }
    
}
