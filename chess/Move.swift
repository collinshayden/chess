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
    
    init(whiteOrg: String, whiteNew: String) {
        self.whiteOrg = whiteOrg
        self.whiteNew = whiteNew
        self.blackOrg = " "
        self.blackNew = " "
    }
    
    func setBlackMove(blackOrg: String, blackNew: String) {
        self.blackOrg = blackOrg
        self.blackNew = blackNew
    }
    
    func getWhiteMove() -> String {
        return whiteOrg + " -> " + whiteNew
    }
    
    func getBlackMove() -> String {
        if blackOrg == " " && blackNew == " "{
            return " "
        }
        else {
            return blackOrg + " -> " + blackNew
        }
    }
}
