//
//  PopUpViewController.swift
//  chess
//
//  Created by Hayden Collins on 12/10/20.
//  Copyright © 2020 Hayden Collins. All rights reserved.
//

import Cocoa
var playingColor = "white"
var stockfishStatus = false

class PopUpViewController: NSViewController {
    @IBAction func playingColorWhite(_ sender: Any) {
        playingColor = "white"
    }
    @IBAction func playingColorBlack(_ sender: Any) {
        playingColor = "black"
    }
    @IBAction func stockfishEnable(_ sender: Any) {
        stockfishStatus = true
    }
    @IBAction func stockfishDisable(_ sender: Any) {
        stockfishStatus = false
    }
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    func returnPlayingColor() -> String{
        return playingColor
    }
    func returnStockfishStatus() -> Bool{
        return stockfishStatus
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
