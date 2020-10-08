//
//  BoardSquare.swift
//  chess
//
//  Created by Hayden Collins on 10/5/20.
//  Copyright © 2020 Hayden Collins. All rights reserved.
//

import Foundation
import Cocoa


class BoardSquare {
    let piece: Piece
    let button: NSButton
    

    init(piece: Piece, button: NSButton){
        self.piece = piece
        self.button = button
    }
}
