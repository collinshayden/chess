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
    var castlingAvailable = false
    
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
    
    func updateBoard(boardSquareLocation: String) {
        //updating boardDict
        boardDict[boardSquareLocation] = boardSquareToMove
        boardDict[originalCord] = nil
        boardSquareToMove?.piece.hasMoved = true
        //clearing legal moves
        legalMoves = []
        showLegalMoves(arr: legalMoves)
        //resetting selected piece to nil
        boardSquareToMove = nil
        if promotionAvailable() == true {
            promoteToQueen(boardSquareLocation: boardSquareLocation)
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

    func boardSquareClicked(boardSquareLocation: String) {//when a button is clicked
        if boardSquareToMove == nil{
            if boardDict[boardSquareLocation]?.piece.color == "white" && whiteTurn == true {
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
                if castlingAvailable == true {//if castling is a legal move
                    performCastle(boardSquareLocation: boardSquareLocation)
                }
                if whiteTurn == true {whiteTurn = false} else {whiteTurn = true}//flips turns
                updateBoard(boardSquareLocation: boardSquareLocation)
                updateBoardView(buttons: buttonDict)
            }
            //if it is white's turn and white clicks on another white piece
            else if boardDict[boardSquareLocation]?.piece.color == "white" && whiteTurn == true {
                legalMoves = []//clears legal moves
                legalMoves = getLegalMoves(boardSquareLocation: boardSquareLocation)//reassigns the legal moves of selected piece
                boardSquareToMove = boardDict[boardSquareLocation]//sets the selected piece to the new piece
                originalCord = boardSquareLocation
                showLegalMoves(arr: legalMoves)
            }
            //if it is black's turn and black clicks on another black piece
            else if boardDict[boardSquareLocation]?.piece.color == "black" && whiteTurn == false {
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
                        if boardSquare.piece.hasMoved == false {
                            if boardDict[letterCord+numbers[numIndex+2]] == nil {//if there is no piece
                                legalMoves.append(letterCord+numbers[numIndex+2])//if white pawn hasnt moved, it can move 2 squares
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
                        if boardSquare.piece.hasMoved == false {
                            if boardDict[letterCord+numbers[numIndex-2]] == nil {//if there is no piece
                                legalMoves.append(letterCord+numbers[numIndex-2])//if black pawn hasnt moved, it can move 2 squares
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
                        //if cord is on board; if there is a piece there, if piece is opposite color, it is a legal move
                        if letterIndex+i >= 0 && numIndex+j >= 0 && letterIndex+i < letters.count && numIndex+j < numbers.count {
                            if boardDict[letters[letterIndex+i] + numbers[numIndex + j]] != nil {
                                if boardDict[letters[letterIndex+i] + numbers[numIndex + j]]?.piece.color != boardSquare.piece.color {
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
                //castling
                if boardSquare.piece.hasMoved == false {
                    if boardSquare.piece.color == "white" {//white castling
                        if boardDict["H1"]?.piece.hasMoved == false {//kingside
                            if boardDict["F1"] == nil && boardDict["G1"] == nil {
                                legalMoves.append("G1")
                                castlingAvailable = true
                            }
                        }
                        if boardDict["A1"]?.piece.hasMoved == false {//queenside
                            if boardDict["D1"] == nil && boardDict["C1"] == nil && boardDict["B1"] == nil {
                                legalMoves.append("C1")
                                castlingAvailable = true
                            }
                        }
                    }
                    if boardSquare.piece.color == "black" {//black castling
                        if boardDict["H8"]?.piece.hasMoved == false {//kingside
                            if boardDict["F8"] == nil && boardDict["G8"] == nil {
                                legalMoves.append("G8")
                                castlingAvailable = true
                            }
                        }
                        if boardDict["A8"]?.piece.hasMoved == false {//queenside
                            if boardDict["D8"] == nil && boardDict["C8"] == nil && boardDict["B8"] == nil {
                                legalMoves.append("C8")
                                castlingAvailable = true
                            }
                        }
                    }
                }
            }
        }
        return legalMoves
    }
    
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
        boardDict["E3"] = BoardSquare(piece: Piece(pieceType: "pawn", color: "black", value: 5, hasMoved: false), button: buttons["E3"]!)

        for l in letters {
            boardDict[l+"2"] = BoardSquare(piece: Piece(pieceType: "pawn", color: "white", value: 1, hasMoved: false), button: buttons[l+"2"]!)
        }
        boardDict["A1"] = BoardSquare(piece: Piece(pieceType: "rook", color: "white", value: 5, hasMoved: false), button: buttons["A1"]!)
        boardDict["H1"] = BoardSquare(piece: Piece(pieceType: "rook", color: "white", value: 5, hasMoved: false), button: buttons["H1"]!)
        boardDict["B1"] = BoardSquare(piece: Piece(pieceType: "knight", color: "white", value: 3, hasMoved: false), button: buttons["B1"]!)
        boardDict["G1"] = BoardSquare(piece: Piece(pieceType: "knight", color: "white", value: 3, hasMoved: false), button: buttons["G1"]!)
        boardDict["C1"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "white", value: 3, hasMoved: false), button: buttons["C1"]!)
        boardDict["F1"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "white", value: 3, hasMoved: false), button: buttons["F1"]!)
        boardDict["E1"] = BoardSquare(piece: Piece(pieceType: "king", color: "white", value: 0, hasMoved: false), button: buttons["E1"]!)
        boardDict["D1"] = BoardSquare(piece: Piece(pieceType: "queen", color: "white", value: 9, hasMoved: false), button: buttons["D1"]!)

        //black
        for l in letters {
            boardDict[l+"7"] = BoardSquare(piece: Piece(pieceType: "pawn", color: "black", value: 1, hasMoved: false), button:buttons[l+"7"]!)
        }
        boardDict["A8"] = BoardSquare(piece: Piece(pieceType: "rook", color: "black", value: 5, hasMoved: false), button:buttons["A8"]!)
        boardDict["H8"] = BoardSquare(piece: Piece(pieceType: "rook", color: "black", value: 5, hasMoved: false), button:buttons["H8"]!)
        boardDict["B8"] = BoardSquare(piece: Piece(pieceType: "knight", color: "black", value: 3, hasMoved: false), button:buttons["B8"]!)
        boardDict["G8"] = BoardSquare(piece: Piece(pieceType: "knight", color: "black", value: 3, hasMoved: false), button:buttons["G8"]!)
        boardDict["C8"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "black", value: 3, hasMoved: false), button:buttons["C8"]!)
        boardDict["F8"] = BoardSquare(piece: Piece(pieceType: "bishop", color: "black", value: 3, hasMoved: false), button:buttons["F8"]!)
        boardDict["E8"] = BoardSquare(piece: Piece(pieceType: "king", color: "black", value: 0, hasMoved: false), button:buttons["E8"]!)
        boardDict["D8"] = BoardSquare(piece: Piece(pieceType: "queen", color: "black", value: 9, hasMoved: false), button:buttons["D8"]!)
    }
    
    func performCastle(boardSquareLocation: String) {
        if boardSquareLocation == "G1" {//white kingside
            boardDict[boardSquareLocation] = boardSquareToMove
            boardDict["F1"] = boardDict["H1"]
            boardSquareToMove?.piece.hasMoved = true
            boardDict[originalCord] = nil
            boardDict["H1"]?.piece.hasMoved = true
            boardDict["H1"] = nil
            castlingAvailable = false
        }
        if boardSquareLocation == "C1" {//white queenside
            boardDict[boardSquareLocation] = boardSquareToMove
            boardDict["D1"] = boardDict["A1"]
            boardSquareToMove?.piece.hasMoved = true
            boardDict[originalCord] = nil
            boardDict["A1"]?.piece.hasMoved = true
            boardDict["A1"] = nil
            castlingAvailable = false
        }
        if boardSquareLocation == "G8" {//black kingside
            boardDict[boardSquareLocation] = boardSquareToMove
            boardDict["F8"] = boardDict["H8"]
            boardSquareToMove?.piece.hasMoved = true
            boardDict[originalCord] = nil
            boardDict["H8"]?.piece.hasMoved = true
            boardDict["H8"] = nil
            castlingAvailable = false
        }
        if boardSquareLocation == "C8" {//black queenside
            boardDict[boardSquareLocation] = boardSquareToMove
            boardDict["D8"] = boardDict["A8"]
            boardSquareToMove?.piece.hasMoved = true
            boardDict[originalCord] = nil
            boardDict["A8"]?.piece.hasMoved = true
            boardDict["A8"] = nil
            castlingAvailable = false
        }
    }
    func promotionAvailable() -> Bool {
        for l in letters {
            if boardDict[l+"8"]?.piece.pieceType == "pawn" {
                return true
            }
            if boardDict[l+"1"]?.piece.pieceType == "pawn" {
                return true
            }
        }
        return false
    }
    
    func promoteToQueen(boardSquareLocation: String){
        if boardDict[boardSquareLocation]?.piece.color == "white" {
            boardDict[boardSquareLocation] = BoardSquare(piece: Piece(pieceType: "queen", color: "white", value: 9, hasMoved: true), button: buttons[boardSquareLocation]!)
        }
        else {
            boardDict[boardSquareLocation] = BoardSquare(piece: Piece(pieceType: "queen", color: "black", value: 9, hasMoved: true), button: buttons[boardSquareLocation]!)
        }
    }
}

