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
    var legalMoves = Array<String>()
    var whiteTurn = true
    var boardSquareToMove : BoardSquare?
    var originalCord : String!
    
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
        boardDict["E6"] = BoardSquare(piece: Piece(pieceType: "rook", color: "white"), button: buttons["E6"]!)

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
    
    //this displays the pieces on the view based on boardDict
    func updateBoardView(buttons: Dictionary<String,NSButton>){
        for l in letters {
            for n in numbers {
                let pieceColor = boardDict[l+n]?.piece.color
                if (boardDict[l+n]?.piece.pieceType == "pawn"){
                    buttons[l+n]!.image = NSImage(named: "pawn_" + pieceColor!)
                }
                if (boardDict[l+n]?.piece.pieceType == "rook"){
                    buttons[l+n]!.image = NSImage(named: "rook_" + pieceColor!)
                }
                if (boardDict[l+n]?.piece.pieceType == "bishop"){
                    buttons[l+n]!.image = NSImage(named: "bishop_" + pieceColor!)
                }
                if (boardDict[l+n]?.piece.pieceType == "knight"){
                    buttons[l+n]!.image = NSImage(named: "knight_" + pieceColor!)
                }
                if (boardDict[l+n]?.piece.pieceType == "king"){
                    buttons[l+n]!.image = NSImage(named: "king_" + pieceColor!)
                }
                if (boardDict[l+n]?.piece.pieceType == "queen"){
                    buttons[l+n]!.image = NSImage(named: "queen_" + pieceColor!)
                }
            }
        }
    }
    
    func boardSquareClicked(boardSquareLocation: String) {//when a button is clicked
        if boardSquareToMove == nil{
            if boardDict[boardSquareLocation]?.piece.color == "white" && whiteTurn == true{
                legalMoves = getLegalMoves(boardSquareLocation: boardSquareLocation)
                showLegalMoves(arr: legalMoves)
                boardSquareToMove = boardDict[boardSquareLocation]
                originalCord = boardSquareLocation
            }
            else if boardDict[boardSquareLocation]?.piece.color == "black" && whiteTurn == false {
                legalMoves = getLegalMoves(boardSquareLocation: boardSquareLocation)
                showLegalMoves(arr: legalMoves)
                boardSquareToMove = boardDict[boardSquareLocation]
                originalCord = boardSquareLocation
            }
        }
        else if let _ = boardSquareToMove {
            if legalMoves.contains(boardSquareLocation) {
                //updating boardDict
                boardDict[boardSquareLocation] = boardSquareToMove
                boardDict[originalCord] = nil
                //clearing legalMoves
                legalMoves = []
                showLegalMoves(arr: legalMoves)
                //resetting variables
                boardSquareToMove = nil
                if whiteTurn == true {
                    whiteTurn = false
                }
                else {
                    whiteTurn = true
                }
                
                updateBoardView(buttons: buttonDict)
            } else if boardDict[boardSquareLocation]?.piece.color == "white" {
                legalMoves = []
                legalMoves = getLegalMoves(boardSquareLocation: boardSquareLocation)
                boardSquareToMove = boardDict[boardSquareLocation]
                originalCord = boardSquareLocation
                showLegalMoves(arr: legalMoves)
            }
        }
    }
    
    func getLegalMoves(boardSquareLocation: String) -> Array<String> {//returns an array of legalMoves
        if let boardSquare = boardDict[boardSquareLocation] {//if there is a BoardSquare(a piece) at that coordinate, if not nothing happens
        let letterCord = boardSquareLocation.prefix(1)
        let numCord = boardSquareLocation.suffix(1)
        let letterIndex = letters.firstIndex(of: String(letterCord))!
        let numIndex = numbers.firstIndex(of: String(numCord))!
        var i = 1
            
            if boardSquare.piece.pieceType == "pawn" {
                if boardSquare.piece.color == "white" {
                    if boardDict[letterCord+numbers[numIndex+1]] == nil {//if there is no piece
                        legalMoves.append(letterCord+numbers[numIndex+1])//white pawn can move up 1 square
                        if boardDict[letterCord+numbers[numIndex+2]] == nil {//if there is no piece
                            if numCord == "2" {
                                legalMoves.append(letterCord+"4")//if white pawn hasnt moved, it can move 2 squares
                            }
                        }
                    }
                    //white pawn can capture up right 1 square
                    if letterIndex+1 <= 7 && numIndex+1 <= 7 {
                        if boardDict[letters[letterIndex+1]+numbers[numIndex+1]] != nil {
                            if boardDict[letters[letterIndex+1]+numbers[numIndex+1]]?.piece.color != boardSquare.piece.color {
                                legalMoves.append(letters[letterIndex+1]+numbers[numIndex+1])
                            }
                        }
                    }
                    //white pawn can capture up left 1 square
                    if letterIndex-1 >= 0 && numIndex+1 <= 7 {
                        if boardDict[letters[letterIndex-1]+numbers[numIndex+1]] != nil {
                            if boardDict[letters[letterIndex-1]+numbers[numIndex+1]]?.piece.color != boardSquare.piece.color {
                                legalMoves.append(letters[letterIndex-1]+numbers[numIndex+1])
                            }
                        }
                    }
                }
                if boardSquare.piece.color == "black" {
                    if boardDict[letterCord+numbers[numIndex-1]] == nil {//if there is no piece
                        legalMoves.append(letterCord+numbers[numIndex-1])//black pawn can move down 1 square
                        if numCord == "7" {
                            if boardDict[letterCord+numbers[numIndex-2]] == nil {//if there is no piece
                                legalMoves.append(letterCord+"5")//if black pawn hasnt moved, it can move 2 squares
                            }
                        }
                    }
                }
                //black pawn can capture down right 1 square
                if letterIndex+1 <= 7 && numIndex-1 >= 0{
                    if boardDict[letters[letterIndex+1]+numbers[numIndex-1]] != nil {
                        if boardDict[letters[letterIndex+1]+numbers[numIndex-1]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex+1]+numbers[numIndex-1])
                        }
                    }
                }
                //black pawn can capture down left 1 square
                if letterIndex-1 >= 0 && numIndex-1 >= 0 {
                    if boardDict[letters[letterIndex-1]+numbers[numIndex-1]] != nil {
                        if boardDict[letters[letterIndex-1]+numbers[numIndex-1]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex-1]+numbers[numIndex-1])
                        }
                    }
                }
            }
            if boardSquare.piece.pieceType == "rook" {
                //left
                i = 1
                while letterIndex-i >= 0 {
                    if boardDict[letters[letterIndex-i]+numCord] != nil {//if there is a piece on a legal move square
                        if boardDict[letters[letterIndex-i]+numCord]?.piece.color != boardSquare.piece.color {// and the piece is opposite color
                            legalMoves.append(letters[letterIndex-i]+numCord)//it is a legal move
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex-i]+numCord)//if there is no piece, append to legalmoves
                    }
                    i += 1
                }
                //right
                i = 1
                while letterIndex+i <= 7 {
                    if boardDict[letters[letterIndex+i]+numCord] != nil {
                        if boardDict[letters[letterIndex+i]+numCord]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex+i]+numCord)
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex+i]+numCord)
                    }
                    i += 1
                }
                //up
                i = 1
                while numIndex+i <= 7 {
                    if boardDict[letterCord+numbers[numIndex+i]] != nil {
                        if boardDict[letterCord+numbers[numIndex+i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letterCord+numbers[numIndex+i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letterCord+numbers[numIndex+i])
                    }
                    i += 1
                }
                //down
                i = 1
                while numIndex-i >= 0 {
                    if boardDict[letterCord+numbers[numIndex-i]] != nil {
                        if boardDict[letterCord+numbers[numIndex-i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letterCord+numbers[numIndex-i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letterCord+numbers[numIndex-i])
                    }
                    i += 1
                }
            }
            if boardSquare.piece.pieceType == "knight" {
                //possible coordinate moves: +1,+2; -1,+2; -2,+1; -2,-1; -1,-2; +1,-2; +2,-1; +2;+1
                //unfortunately, I'm not sure of a way to for loop the knight moves, so it has to be hardcoded.
                if letterIndex+1 <= 7 && numIndex+2 <= 7 {
                    if boardDict[letters[letterIndex+1]+numbers[numIndex+2]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex+1]+numbers[numIndex+2])
                    }
                }
                if letterIndex-1 >= 0 && numIndex+2 <= 7 {
                    if boardDict[letters[letterIndex-1]+numbers[numIndex+2]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex-1]+numbers[numIndex+2])
                    }
                }
                if letterIndex-2 >= 0 && numIndex+1 <= 7 {
                    if boardDict[letters[letterIndex-2]+numbers[numIndex+1]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex-2]+numbers[numIndex+1])
                    }
                }
                if letterIndex-2 >= 0 && numIndex-1 >= 0 {
                    if boardDict[letters[letterIndex-2]+numbers[numIndex-1]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex-2]+numbers[numIndex-1])
                    }
                }
                if letterIndex-1 >= 0 && numIndex-2 >= 0 {
                    if boardDict[letters[letterIndex-1]+numbers[numIndex-2]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex-1]+numbers[numIndex-2])
                    }
                }
                if letterIndex+1 <= 7 && numIndex-2 >= 0 {
                    if boardDict[letters[letterIndex+1]+numbers[numIndex-2]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex+1]+numbers[numIndex-2])
                    }
                }
                if letterIndex+2 <= 7 && numIndex-1 >= 0 {
                    if boardDict[letters[letterIndex+2]+numbers[numIndex-1]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex+2]+numbers[numIndex-1])
                    }
                }
                if letterIndex+2 <= 7 && numIndex+1 <= 7 {
                    if boardDict[letters[letterIndex+2]+numbers[numIndex+1]]?.piece.color != boardSquare.piece.color {
                        legalMoves.append(letters[letterIndex+2]+numbers[numIndex+1])
                    }
                }
            }
            if boardSquare.piece.pieceType == "bishop" {
                //up right diagonal
                i = 1
                while letterIndex+i <= 7 && numIndex+i <= 7{
                    if boardDict[letters[letterIndex+i]+numbers[numIndex+i]] != nil {//if there is a piece on a legal move square
                        if boardDict[letters[letterIndex+i]+numbers[numIndex+i]]?.piece.color != boardSquare.piece.color {//and it is opposite color
                            legalMoves.append(letters[letterIndex+i]+numbers[numIndex+i])//it is a legal move
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex+i]+numbers[numIndex+i])//if there is no piece, it is a legal move
                    }
                    i += 1
                }
                //down left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex-i >= 0{
                    if boardDict[letters[letterIndex-i]+numbers[numIndex-i]] != nil {
                        if boardDict[letters[letterIndex-i]+numbers[numIndex-i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex-i]+numbers[numIndex-i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex-i]+numbers[numIndex-i])
                    }
                    i += 1
                }
                //down right diagonal
                i = 1
                while letterIndex+i <= 7 && numIndex-i >= 0{
                    if boardDict[letters[letterIndex+i]+numbers[numIndex-i]] != nil {
                        if boardDict[letters[letterIndex+i]+numbers[numIndex-i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex+i]+numbers[numIndex-i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex+i]+numbers[numIndex-i])
                    }
                    i += 1
                }
                //up left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex+i <= 7{
                    if boardDict[letters[letterIndex-i]+numbers[numIndex+i]] != nil {
                        if boardDict[letters[letterIndex-i]+numbers[numIndex+i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex-i]+numbers[numIndex+i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex-i]+numbers[numIndex+i])
                    }
                    i += 1
                }
            }

            if boardSquare.piece.pieceType == "queen"{
                //left
                i = 1
                while letterIndex-i >= 0 {
                    if boardDict[letters[letterIndex-i]+numCord] != nil {//if there is a piece on a legal move square
                        if boardDict[letters[letterIndex-i]+numCord]?.piece.color != boardSquare.piece.color {// and the piece is opposite color
                            legalMoves.append(letters[letterIndex-i]+numCord)//it is a legal move
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex-i]+numCord)//if there is no piece, append to legalmoves
                    }
                    i += 1
                }
                //right
                i = 1
                while letterIndex+i <= 7 {
                    if boardDict[letters[letterIndex+i]+numCord] != nil {
                        if boardDict[letters[letterIndex+i]+numCord]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex+i]+numCord)
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex+i]+numCord)
                    }
                    i += 1
                }
                //up
                i = 1
                while numIndex+i <= 7 {
                    if boardDict[letterCord+numbers[numIndex+i]] != nil {
                        if boardDict[letterCord+numbers[numIndex+i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letterCord+numbers[numIndex+i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letterCord+numbers[numIndex+i])
                    }
                    i += 1
                }
                //down
                i = 1
                while numIndex-i >= 0 {
                    if boardDict[letterCord+numbers[numIndex-i]] != nil {
                        if boardDict[letterCord+numbers[numIndex-i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letterCord+numbers[numIndex-i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letterCord+numbers[numIndex-i])
                    }
                    i += 1
                }
                //up right diagonal
                i = 1
                while letterIndex+i <= 7 && numIndex+i <= 7{
                    if boardDict[letters[letterIndex+i]+numbers[numIndex+i]] != nil {//if there is a piece on a legal move square
                        if boardDict[letters[letterIndex+i]+numbers[numIndex+i]]?.piece.color != boardSquare.piece.color {//and it is opposite color
                            legalMoves.append(letters[letterIndex+i]+numbers[numIndex+i])//it is a legal move
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex+i]+numbers[numIndex+i])//if there is no piece, it is a legal move
                    }
                    i += 1
                }
                //down left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex-i >= 0{
                    if boardDict[letters[letterIndex-i]+numbers[numIndex-i]] != nil {
                        if boardDict[letters[letterIndex-i]+numbers[numIndex-i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex-i]+numbers[numIndex-i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex-i]+numbers[numIndex-i])
                    }
                    i += 1
                }
                //down right diagonal
                i = 1
                while letterIndex+i <= 7 && numIndex-i >= 0{
                    if boardDict[letters[letterIndex+i]+numbers[numIndex-i]] != nil {
                        if boardDict[letters[letterIndex+i]+numbers[numIndex-i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex+i]+numbers[numIndex-i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex+i]+numbers[numIndex-i])
                    }
                    i += 1
                }
                //up left diagonal
                i = 1
                while letterIndex-i >= 0 && numIndex+i <= 7{
                    if boardDict[letters[letterIndex-i]+numbers[numIndex+i]] != nil {
                        if boardDict[letters[letterIndex-i]+numbers[numIndex+i]]?.piece.color != boardSquare.piece.color {
                            legalMoves.append(letters[letterIndex-i]+numbers[numIndex+i])
                        }
                        break
                    }
                    else {
                        legalMoves.append(letters[letterIndex-i]+numbers[numIndex+i])
                    }
                    i += 1
                }
            }
            if boardSquare.piece.pieceType == "king" {
                //can move one square in any direction
                for i in -1...1 {
                    for j in -1...1 {
                        //if cord is on board
                        if letterIndex+i >= 0 && numIndex+j >= 0 && letterIndex+i < letters.count && numIndex+j < numbers.count {
                            //if there is a piece there
                            if boardDict[letters[letterIndex+i] + numbers[numIndex + j]] != nil {
                                //if the piece is not the same color
                                if boardDict[letters[letterIndex+i] + numbers[numIndex + j]]?.piece.color != boardSquare.piece.color {
                                    //that cord is a legal move
                                    legalMoves.append(letters[letterIndex+i] + numbers[numIndex + j])
                                }
                                break
                            }
                            else {
                                legalMoves.append(letters[letterIndex+i] + numbers[numIndex + j])//if there is no piece, it is a legal move
                            }
                        }
                    }
                }
            }
        }
        return legalMoves
    }
    func showLegalMoves(arr: Array<String>) {
        let legalMoves = arr
        //resets the display of legal moves for every click of a piece
        for l in letters {
            for n in numbers {
                if boardDict[l+n] == nil {
                    buttons[l+n]?.image = nil
                }
                if boardDict[l+n] != nil {
                    buttons[l+n]?.image = NSImage(named: (boardDict[l+n]?.piece.pieceType)! + "_" + (boardDict[l+n]?.piece.color)!)
                }
            }
        }
        for cord in legalMoves {
            if boardDict[cord] == nil {
                buttons[cord]?.image = NSImage(named: "legalmovedot")
            }
            else if boardDict[cord] != nil {
                buttons[cord]?.image = NSImage(named: (boardDict[cord]?.piece.pieceType)! + "_" + (boardDict[cord]?.piece.color)! + "_capture")
            }
        }
    }
}
