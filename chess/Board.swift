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
        //initializing all boardDict keys as nil
        for l in letters {
            for n in numbers {
                boardDict[l+n] = nil
            }
        }
        //board setup
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
    //this allows for boardDict to be sent to ViewController via method call
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
            var i = 1
            
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
                i = 1
                while letterIndex-i >= 0 {
                    legalMoves.append(letters[letterIndex-i]+numCord)//left
                    i += 1
                }
                i = 1
                while letterIndex+i <= 7 {
                    legalMoves.append(letters[letterIndex+i]+numCord)//right
                    i += 1
                }
                i = 1
                while numIndex+i <= 7 {
                    legalMoves.append(letterCord+numbers[numIndex+i])//up
                    i += 1
                }
                while numIndex-i >= 0 {
                    legalMoves.append(letterCord+numbers[numIndex-i])//down
                    i += 1
                }
            }
            if boardSquare.piece.pieceType == "knight" {
                //possible coordinate moves: +1,+2; -1,+2; -2,+1; -2,-1; -1,-2; +1,-2; +2,-1; +2;+1
                //unfortunately, I'm not sure of a way to for loop the knight moves, so it has to be hardcoded.
                if letterIndex+1 <= 7 && numIndex+2 <= 7 {
                    legalMoves.append(letters[letterIndex+1]+numbers[numIndex+2])
                }
                if letterIndex-1 >= 0 && numIndex+2 <= 7 {
                    legalMoves.append(letters[letterIndex-1]+numbers[numIndex+2])
                }
                if letterIndex-2 >= 0 && numIndex+1 <= 7 {
                    legalMoves.append(letters[letterIndex-2]+numbers[numIndex+1])
                }
                if letterIndex-2 >= 0 && numIndex-1 >= 0 {
                    legalMoves.append(letters[letterIndex-2]+numbers[numIndex-1])
                }
                if letterIndex-1 >= 0 && numIndex-2 >= 0 {
                    legalMoves.append(letters[letterIndex-1]+numbers[numIndex-2])
                }
                if letterIndex+1 <= 7 && numIndex-2 >= 0 {
                    legalMoves.append(letters[letterIndex+1]+numbers[numIndex-2])
                }
                if letterIndex+2 <= 7 && numIndex-1 >= 0 {
                    legalMoves.append(letters[letterIndex+2]+numbers[numIndex-1])
                }
                if letterIndex+2 <= 7 && numIndex+1 <= 7 {
                    legalMoves.append(letters[letterIndex+2]+numbers[numIndex+1])
                }
            }
            if boardSquare.piece.pieceType == "bishop" {
                //up right diagonal
                i = 1
                while letterIndex+i <= 7 && numIndex+i <= 7{
                    legalMoves.append(letters[letterIndex+i]+numbers[numIndex+i])
                    i += 1
                }
                //down left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex-i >= 0{
                    legalMoves.append(letters[letterIndex-i]+numbers[numIndex-i])
                    i += 1
                }
                //down right diagonal
                i = 1
                while letterIndex+i <= 7 && numIndex-i >= 0{
                    legalMoves.append(letters[letterIndex+i]+numbers[numIndex-i])
                    i += 1
                }
                //up left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex+i <= 7{
                    legalMoves.append(letters[letterIndex-i]+numbers[numIndex+i])
                    i += 1
                }
            }

            if boardSquare.piece.pieceType == "queen"{
                i = 1
                while letterIndex-i >= 0 {
                    legalMoves.append(letters[letterIndex-i]+numCord)//left
                    i += 1
                }
                i = 1
                while letterIndex+i <= 7 {
                    legalMoves.append(letters[letterIndex+i]+numCord)//right
                    i += 1
                }
                i = 1
                while numIndex+i <= 7 {
                    legalMoves.append(letterCord+numbers[numIndex+i])//up
                    i += 1
                }
                while numIndex-i >= 0 {
                    legalMoves.append(letterCord+numbers[numIndex-i])//down
                    i += 1
                }
                //up right diagonal
                var i = 1
                while letterIndex+i <= 7 && numIndex+i <= 7{
                    legalMoves.append(letters[letterIndex+i]+numbers[numIndex+i])
                    i += 1
                }
                //down left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex-i >= 0{
                    legalMoves.append(letters[letterIndex-i]+numbers[numIndex-i])
                    i += 1
                }
//                //down right diagonal
                i = 1
                while letterIndex+i <= 7 && numIndex-i >= 0{
                    legalMoves.append(letters[letterIndex+i]+numbers[numIndex-i])
                    i += 1
                }
//                //up left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex+i <= 7{
                    legalMoves.append(letters[letterIndex-i]+numbers[numIndex+i])
                    i += 1
                }
            }
            if boardSquare.piece.pieceType == "king" {
                //can move one square in any direction
                for i in -1...1 {
                    for j in -1...1 {
                        if letterIndex+i >= 0 && numIndex+j >= 0 && letterIndex+i < letters.count && numIndex+j < numbers.count {
                            legalMoves.append(letters[letterIndex+i] + numbers[numIndex + j])
                        }
                    }
                }
            }
            showLegalMoves(arr: legalMoves)
        }
    }
    func showLegalMoves(arr: Array<String>) {
        let legalMoves = arr
        //resets the display of legal moves for every click of a piece
        for l in letters {
            for n in numbers {
                if boardDict[l+n] == nil {
                    buttons[l+n]?.image = nil
                }
            }
        }
        for cord in legalMoves {
            if boardDict[cord] == nil {
                buttons[cord]?.image = NSImage(named: "legalmovedot")
            }
        }
    }
}
