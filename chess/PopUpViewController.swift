//
//  PopUpViewController.swift
//  chess
//
//  Created by Hayden Collins on 12/10/20.
//  Copyright © 2020 Hayden Collins. All rights reserved.
//

import Cocoa

class PopUpViewController: NSViewController {
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
