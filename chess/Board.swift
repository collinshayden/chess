//
//  Board.swift
//  chess
//
//  Created by Hayden Collins on 9/29/20.
//  Copyright © 2020 Hayden Collins. All rights reserved.
//

import Foundation
import Cocoa


class Board {
    var boardDict = [String:BoardSquare]()
    var dict = [String:BoardSquare]()
    var buttons = [String:NSButton]()
    
    
    func setBoardButtons(buttons: [String:NSButton]) {
        self.buttons = buttons
        //white
        for l in letters {
            boardDict[l+"2"] = BoardSquare(piece: Piece(pieceType: "pawn", color: "white"), button: buttons[l+"2"]!)
        }
        boardDict["A1"] = BoardSquare(piece: Piece(pieceType: "rook", color: "white"), button: buttons["A1"]!)
        boardDict["H1"] = BoardSquare(piece: Piece(pieceType: "rook", color: "white"), button: buttons["H1"]!)
        boardDict["B1"] = BoardSquare(piece: Piece(pieceType: "knight", color: "white"), button: buttons["B1"]!)
        boardDict["G1"] = BoardSquare(piece: Piece(pieceType: "knight", color: "white"), button: buttons["G1"]!)
        boardDict["C1"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "white"), button: buttons["C1"]!)
        boardDict["F1"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "white"), button: buttons["F1"]!)
        boardDict["E1"] = BoardSquare(piece: Piece(pieceType: "king", color: "white"), button: buttons["E1"]!)
        boardDict["D1"] = BoardSquare(piece: Piece(pieceType: "queen", color: "white"), button: buttons["D1"]!)

        //black
        for l in letters {
            boardDict[l+"7"] = BoardSquare(piece: Piece(pieceType: "pawn", color: "black"), button:buttons[l+"7"]!)
        }
        boardDict["A8"] = BoardSquare(piece: Piece(pieceType: "rook", color: "black"), button:buttons["A8"]!)
        boardDict["H8"] = BoardSquare(piece: Piece(pieceType: "rook", color: "black"), button:buttons["H8"]!)
        boardDict["B8"] = BoardSquare(piece: Piece(pieceType: "knight", color: "black"), button:buttons["B8"]!)
        boardDict["G8"] = BoardSquare(piece: Piece(pieceType: "knight", color: "black"), button:buttons["G8"]!)
        boardDict["C8"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "black"), button:buttons["C8"]!)
        boardDict["F8"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "black"), button:buttons["F8"]!)
        boardDict["E8"] = BoardSquare(piece: Piece(pieceType: "king", color: "black"), button:buttons["E8"]!)
        boardDict["D8"] = BoardSquare(piece: Piece(pieceType: "queen", color: "black"), button:buttons["D8"]!)
    }
    
    func sendboardDict(completion: ((_ dict: Dictionary<String,BoardSquare>) -> Void)) {
        dict = boardDict
        
        completion(dict)
    }
    
    func boardSquareClicked(boardSquareLocation: String) {//when a button is clicked
        if let boardSquare = boardDict[boardSquareLocation] {//if there is a BoardSquare(a piece) at that coordinate, if not nothing happens
            let letterCord = boardSquareLocation.prefix(1)
            let numCord = boardSquareLocation.suffix(1)
            let letterIndex = letters.firstIndex(of: String(letterCord))!
            let numIndex = numbers.firstIndex(of: String(numCord))!
            var legalMoves = Array<String>()
            
            
            if boardSquare.piece.pieceType == "pawn" {
                if boardSquare.piece.color == "white" {
                    legalMoves.append(letterCord+numbers[numIndex+1])//white pawn can move up 1 square
                    if numCord == "2" {
                        legalMoves.append(letterCord+"4")//if white pawn hasnt moved, it can move 2 squares
                    }
                }
                if boardSquare.piece.color == "black" {
                    legalMoves.append(letterCord+numbers[numIndex-1])//black pawn can move down 1 square
                    if numCord == "7" {
                        legalMoves.append(letterCord+"5")//if black pawn hasnt moved, it can move 2 squares
                    }
                }
            }
            if boardSquare.piece.pieceType == "rook" {
                for l in letters {
                    legalMoves.append(l+numCord)//horizontal
                }
                for n in numbers {
                    legalMoves.append(letterCord+n)//vertical
                }
            }
            if boardSquare.piece.pieceType == "bishop" {
                for n in 1...8 {
                    legalMoves.append(letters[n]+String(n))//not how this should be, think about diagonals
                }
            }
            if boardSquare.piece.pieceType == "knight" {
                
            }
        }
    }
}

