//
//  Move.swift
//  chess
//
//  Created by Hayden Collins on 11/10/20.
//  Copyright © 2020 Hayden Collins. All rights reserved.
//

import Foundation

class Move {
    let whiteOrg : String
    let whiteNew : String
    var blackOrg : String
    var blackNew : String
    var whiteCapture : Bool
    var blackCapture : Bool
    
    init(whiteOrg: String, whiteNew: String, whiteCapture: Bool) {
        self.whiteCapture = whiteCapture
        self.whiteOrg = whiteOrg.lowercased()
        self.whiteNew = whiteNew.lowercased()
        self.blackOrg = " "
        self.blackNew = " "
        self.blackCapture = false
    }
    
    func setBlackMove(blackOrg: String, blackNew: String, blackCapture: Bool) {
        self.blackOrg = blackOrg.lowercased()
        self.blackNew = blackNew.lowercased()
        self.blackCapture = blackCapture
    }
    
    func getWhiteMove() -> String {
        if whiteCapture == true {
            return whiteOrg + "x" + whiteNew
        }
        else {
            return whiteOrg + whiteNew
        }
    }
    
    func getBlackMove() -> String {
        if blackOrg == " " && blackNew == " "{
            return " "
        }
        else if blackCapture == true {
            return blackOrg + "x" + blackNew
        }
        else {
            return blackOrg + blackNew
        }
    }
}
