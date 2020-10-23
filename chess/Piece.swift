//
//  Pieces.swift
//  chess
//
//  Created by Hayden Collins on 9/29/20.
//  Copyright © 2020 Hayden Collins. All rights reserved.
//

import Foundation

class Piece {
    let pieceType: String
    let color: String
    let value: Int
    var hasMoved: Bool
    var pieceLegalMoves: Array<String>
    
    init(pieceType: String, color: String, value: Int, hasMoved: Bool, pieceLegalMoves: Array<String>){
        self.pieceType = pieceType
        self.color = color
        self.value = value
        self.hasMoved = hasMoved
        self.pieceLegalMoves = pieceLegalMoves
    }
}
