//
//  ViewController.swift
//  chess
//
//  Created by Hayden Collins on 9/28/20.
//  Copyright © 2020 Hayden Collins. All rights reserved.
//

import Cocoa
//arrays of letters and numbers to make iterating convienient
let letters = Array<String>(arrayLiteral: "A","B","C","D","E","F","G","H")
let numbers = Array<String>(arrayLiteral: "1","2","3","4","5","6","7","8")
var buttonDict = [String:NSButton]()//dictionary for all the button variables
var whiteMaterialImages = Array<NSImageView>()
var blackMaterialImages = Array<NSImageView>()
var moveColumnArr = Array<NSTextField>()
var whiteColumnArr = Array<NSTextField>()
var blackColumnArr = Array<NSTextField>()

var board = Board()


class ViewController: NSViewController {
    @IBOutlet weak var ButtonA1: NSButton!
    @IBOutlet weak var ButtonA2: NSButton!
    @IBOutlet weak var ButtonA3: NSButton!
    @IBOutlet weak var ButtonA4: NSButton!
    @IBOutlet weak var ButtonA5: NSButton!
    @IBOutlet weak var ButtonA6: NSButton!
    @IBOutlet weak var ButtonA7: NSButton!
    @IBOutlet weak var ButtonA8: NSButton!
    @IBOutlet weak var ButtonB1: NSButton!
    @IBOutlet weak var ButtonB2: NSButton!
    @IBOutlet weak var ButtonB3: NSButton!
    @IBOutlet weak var ButtonB4: NSButton!
    @IBOutlet weak var ButtonB5: NSButton!
    @IBOutlet weak var ButtonB6: NSButton!
    @IBOutlet weak var ButtonB7: NSButton!
    @IBOutlet weak var ButtonB8: NSButton!
    @IBOutlet weak var ButtonC1: NSButton!
    @IBOutlet weak var ButtonC2: NSButton!
    @IBOutlet weak var ButtonC3: NSButton!
    @IBOutlet weak var ButtonC4: NSButton!
    @IBOutlet weak var ButtonC5: NSButton!
    @IBOutlet weak var ButtonC6: NSButton!
    @IBOutlet weak var ButtonC7: NSButton!
    @IBOutlet weak var ButtonC8: NSButton!
    @IBOutlet weak var ButtonD1: NSButton!
    @IBOutlet weak var ButtonD2: NSButton!
    @IBOutlet weak var ButtonD3: NSButton!
    @IBOutlet weak var ButtonD4: NSButton!
    @IBOutlet weak var ButtonD5: NSButton!
    @IBOutlet weak var ButtonD6: NSButton!
    @IBOutlet weak var ButtonD7: NSButton!
    @IBOutlet weak var ButtonD8: NSButton!
    @IBOutlet weak var ButtonE1: NSButton!
    @IBOutlet weak var ButtonE2: NSButton!
    @IBOutlet weak var ButtonE3: NSButton!
    @IBOutlet weak var ButtonE4: NSButton!
    @IBOutlet weak var ButtonE5: NSButton!
    @IBOutlet weak var ButtonE6: NSButton!
    @IBOutlet weak var ButtonE7: NSButton!
    @IBOutlet weak var ButtonE8: NSButton!
    @IBOutlet weak var ButtonF1: NSButton!
    @IBOutlet weak var ButtonF2: NSButton!
    @IBOutlet weak var ButtonF3: NSButton!
    @IBOutlet weak var ButtonF4: NSButton!
    @IBOutlet weak var ButtonF5: NSButton!
    @IBOutlet weak var ButtonF6: NSButton!
    @IBOutlet weak var ButtonF7: NSButton!
    @IBOutlet weak var ButtonF8: NSButton!
    @IBOutlet weak var ButtonG1: NSButton!
    @IBOutlet weak var ButtonG2: NSButton!
    @IBOutlet weak var ButtonG3: NSButton!
    @IBOutlet weak var ButtonG4: NSButton!
    @IBOutlet weak var ButtonG5: NSButton!
    @IBOutlet weak var ButtonG6: NSButton!
    @IBOutlet weak var ButtonG7: NSButton!
    @IBOutlet weak var ButtonG8: NSButton!
    @IBOutlet weak var ButtonH1: NSButton!
    @IBOutlet weak var ButtonH2: NSButton!
    @IBOutlet weak var ButtonH3: NSButton!
    @IBOutlet weak var ButtonH4: NSButton!
    @IBOutlet weak var ButtonH5: NSButton!
    @IBOutlet weak var ButtonH6: NSButton!
    @IBOutlet weak var ButtonH7: NSButton!
    @IBOutlet weak var ButtonH8: NSButton!
    
    //Text Field Variables
    @IBOutlet weak var whiteScore: NSTextField!
    @IBOutlet weak var blackScore: NSTextField!
    @IBOutlet weak var MoveCount: NSTextField!
    @IBOutlet weak var checkMateText: NSTextField!
    @IBOutlet weak var engineStatus: NSTextField!
    
    //Score ImageView Variables
    @IBOutlet weak var whiteScoreIndex0: NSImageView!
    @IBOutlet weak var whiteScoreIndex1: NSImageView!
    @IBOutlet weak var whiteScoreIndex2: NSImageView!
    @IBOutlet weak var whiteScoreIndex3: NSImageView!
    @IBOutlet weak var whiteScoreIndex4: NSImageView!
    @IBOutlet weak var whiteScoreIndex5: NSImageView!
    @IBOutlet weak var whiteScoreIndex6: NSImageView!
    @IBOutlet weak var whiteScoreIndex7: NSImageView!
    @IBOutlet weak var whiteScoreIndex8: NSImageView!
    @IBOutlet weak var whiteScoreIndex9: NSImageView!
    @IBOutlet weak var whiteScoreIndex10: NSImageView!
    @IBOutlet weak var whiteScoreIndex11: NSImageView!
    @IBOutlet weak var blackScoreIndex0: NSImageView!
    @IBOutlet weak var blackScoreIndex1: NSImageView!
    @IBOutlet weak var blackScoreIndex2: NSImageView!
    @IBOutlet weak var blackScoreIndex3: NSImageView!
    @IBOutlet weak var blackScoreIndex4: NSImageView!
    @IBOutlet weak var blackScoreIndex5: NSImageView!
    @IBOutlet weak var blackScoreIndex6: NSImageView!
    @IBOutlet weak var blackScoreIndex7: NSImageView!
    @IBOutlet weak var blackScoreIndex8: NSImageView!
    @IBOutlet weak var blackScoreIndex9: NSImageView!
    @IBOutlet weak var blackScoreIndex10: NSImageView!
    @IBOutlet weak var blackScoreIndex11: NSImageView!
    
    @IBOutlet weak var tableView: NSTableView!
    
    //function calls for when a button is pressed
    @IBAction func ButtonActionA1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A1")
    }
    @IBAction func ButtonActionA2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A2")
    }
    @IBAction func ButtonActionA3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A3")
    }
    @IBAction func ButtonActionA4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A4")
    }
    @IBAction func ButtonActionA5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A5")
    }
    @IBAction func ButtonActionA6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A6")
    }
    @IBAction func ButtonActionA7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A7")
    }
    @IBAction func ButtonActionA8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "A8")
    }
    @IBAction func ButtonActionB1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B1")
    }
    @IBAction func ButtonActionB2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B2")
    }
    @IBAction func ButtonActionB3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B3")
    }
    @IBAction func ButtonActionB4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B4")
    }
    @IBAction func ButtonActionB5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B5")
    }
    @IBAction func ButtonActionB6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B6")
    }
    @IBAction func ButtonActionB7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B7")
    }
    @IBAction func ButtonActionB8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "B8")
    }
    @IBAction func ButtonActionC1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C1")
    }
    @IBAction func ButtonActionC2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C2")
    }
    @IBAction func ButtonActionC3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C3")
    }
    @IBAction func ButtonActionC4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C4")
    }
    @IBAction func ButtonActionC5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C5")
    }
    @IBAction func ButtonActionC6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C6")
    }
    @IBAction func ButtonActionC7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C7")
    }
    @IBAction func ButtonActionC8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "C8")
    }
    @IBAction func ButtonActionD1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D1")
    }
    @IBAction func ButtonActionD2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D2")
    }
    @IBAction func ButtonActionD3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D3")
    }
    @IBAction func ButtonActionD4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D4")
    }
    @IBAction func ButtonActionD5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D5")
    }
    @IBAction func ButtonActionD6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D6")
    }
    @IBAction func ButtonActionD7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D7")
    }
    @IBAction func ButtonActionD8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "D8")
    }
    @IBAction func ButtonActionE1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E1")
    }
    @IBAction func ButtonActionE2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E2")
    }
    @IBAction func ButtonActionE3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E3")
    }
    @IBAction func ButtonActionE4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E4")
    }
    @IBAction func ButtonActionE5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E5")
    }
    @IBAction func ButtonActionE6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E6")
    }
    @IBAction func ButtonActionE7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E7")
    }
    @IBAction func ButtonActionE8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "E8")
    }
    @IBAction func ButtonActionF1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F1")
    }
    @IBAction func ButtonActionF2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F2")
    }
    @IBAction func ButtonActionF3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F3")
    }
    @IBAction func ButtonActionF4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F4")
    }
    @IBAction func ButtonActionF5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F5")
    }
    @IBAction func ButtonActionF6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F6")
    }
    @IBAction func ButtonActionF7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F7")
    }
    @IBAction func ButtonActionF8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "F8")
    }
    @IBAction func ButtonActionG1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G1")
    }
    @IBAction func ButtonActionG2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G2")
    }
    @IBAction func ButtonActionG3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G3")
    }
    @IBAction func ButtonActionG4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G4")
    }
    @IBAction func ButtonActionG5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G5")
    }
    @IBAction func ButtonActionG6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G6")
    }
    @IBAction func ButtonActionG7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G7")
    }
    @IBAction func ButtonActionG8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "G8")
    }
    @IBAction func ButtonActionH1(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H1")
    }
    @IBAction func ButtonActionH2(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H2")
    }
    @IBAction func ButtonActionH3(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H3")
    }
    @IBAction func ButtonActionH4(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H4")
    }
    @IBAction func ButtonActionH5(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H5")
    }
    @IBAction func ButtonActionH6(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H6")
    }
    @IBAction func ButtonActionH7(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H7")
    }
    @IBAction func ButtonActionH8(_ sender: Any) {
        board.boardSquareClicked(boardSquareLocation: "H8")
    }
    @IBAction func resetButton(_ sender: Any) {
        board.setBoardDict(buttons: buttonDict)
        board.setGlobalVariables(tempWhiteScore: whiteScore, tempBlackScore: blackScore, tempMoveCount: MoveCount, tempgameEndText: checkMateText, tempwhiteScoreImageViews: whiteMaterialImages, tempblackScoreImageViews: blackMaterialImages, temptableView: tableView)
        board.showMoveCount()
        board.movesArr = []
        tableView.reloadData()
        board.updateBoardView(buttons: buttonDict)
        showPopUp()
    }
    
    func showPopUp() {
        let popUpVC = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.delegate = self
    }
    
    override func viewDidLoad() {// Do any additional setup after loading the view.
        super.viewDidLoad()
        showPopUp()
        
        initializeasWhite()
        setWhiteScoreViewArray()
        setBlackScoreViewArray()
        
        //Set Table View Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        board.setBoardDict(buttons: buttonDict)
        board.setGlobalVariables(tempWhiteScore: whiteScore, tempBlackScore: blackScore, tempMoveCount: MoveCount, tempgameEndText: checkMateText, tempwhiteScoreImageViews: whiteMaterialImages, tempblackScoreImageViews: blackMaterialImages, temptableView: tableView)
        board.updateBoardView(buttons: buttonDict)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func initializeasWhite() {
        //setting values for ButtonDict
        buttonDict["A1"] = ButtonA1
        buttonDict["A2"] = ButtonA2
        buttonDict["A3"] = ButtonA3
        buttonDict["A4"] = ButtonA4
        buttonDict["A5"] = ButtonA5
        buttonDict["A6"] = ButtonA6
        buttonDict["A7"] = ButtonA7
        buttonDict["A8"] = ButtonA8
        buttonDict["B1"] = ButtonB1
        buttonDict["B2"] = ButtonB2
        buttonDict["B3"] = ButtonB3
        buttonDict["B4"] = ButtonB4
        buttonDict["B5"] = ButtonB5
        buttonDict["B6"] = ButtonB6
        buttonDict["B7"] = ButtonB7
        buttonDict["B8"] = ButtonB8
        buttonDict["C1"] = ButtonC1
        buttonDict["C2"] = ButtonC2
        buttonDict["C3"] = ButtonC3
        buttonDict["C4"] = ButtonC4
        buttonDict["C5"] = ButtonC5
        buttonDict["C6"] = ButtonC6
        buttonDict["C7"] = ButtonC7
        buttonDict["C8"] = ButtonC8
        buttonDict["D1"] = ButtonD1
        buttonDict["D2"] = ButtonD2
        buttonDict["D3"] = ButtonD3
        buttonDict["D4"] = ButtonD4
        buttonDict["D5"] = ButtonD5
        buttonDict["D6"] = ButtonD6
        buttonDict["D7"] = ButtonD7
        buttonDict["D8"] = ButtonD8
        buttonDict["E1"] = ButtonE1
        buttonDict["E2"] = ButtonE2
        buttonDict["E3"] = ButtonE3
        buttonDict["E4"] = ButtonE4
        buttonDict["E5"] = ButtonE5
        buttonDict["E6"] = ButtonE6
        buttonDict["E7"] = ButtonE7
        buttonDict["E8"] = ButtonE8
        buttonDict["F1"] = ButtonF1
        buttonDict["F2"] = ButtonF2
        buttonDict["F3"] = ButtonF3
        buttonDict["F4"] = ButtonF4
        buttonDict["F5"] = ButtonF5
        buttonDict["F6"] = ButtonF6
        buttonDict["F7"] = ButtonF7
        buttonDict["F8"] = ButtonF8
        buttonDict["G1"] = ButtonG1
        buttonDict["G2"] = ButtonG2
        buttonDict["G3"] = ButtonG3
        buttonDict["G4"] = ButtonG4
        buttonDict["G5"] = ButtonG5
        buttonDict["G6"] = ButtonG6
        buttonDict["G7"] = ButtonG7
        buttonDict["G8"] = ButtonG8
        buttonDict["H1"] = ButtonH1
        buttonDict["H2"] = ButtonH2
        buttonDict["H3"] = ButtonH3
        buttonDict["H4"] = ButtonH4
        buttonDict["H5"] = ButtonH5
        buttonDict["H6"] = ButtonH6
        buttonDict["H7"] = ButtonH7
        buttonDict["H8"] = ButtonH8
    }
    
    func initializeasBlack() {
        //setting values for ButtonDict
        buttonDict["A1"] = ButtonH8
        buttonDict["A2"] = ButtonH7
        buttonDict["A3"] = ButtonH6
        buttonDict["A4"] = ButtonH5
        buttonDict["A5"] = ButtonH4
        buttonDict["A6"] = ButtonH3
        buttonDict["A7"] = ButtonH2
        buttonDict["A8"] = ButtonH1
        buttonDict["B1"] = ButtonG8
        buttonDict["B2"] = ButtonG7
        buttonDict["B3"] = ButtonG6
        buttonDict["B4"] = ButtonG5
        buttonDict["B5"] = ButtonG4
        buttonDict["B6"] = ButtonG3
        buttonDict["B7"] = ButtonG2
        buttonDict["B8"] = ButtonG1
        buttonDict["C1"] = ButtonF8
        buttonDict["C2"] = ButtonF7
        buttonDict["C3"] = ButtonF6
        buttonDict["C4"] = ButtonF5
        buttonDict["C5"] = ButtonF4
        buttonDict["C6"] = ButtonF3
        buttonDict["C7"] = ButtonF2
        buttonDict["C8"] = ButtonF1
        buttonDict["D1"] = ButtonE8
        buttonDict["D2"] = ButtonE7
        buttonDict["D3"] = ButtonE6
        buttonDict["D4"] = ButtonE5
        buttonDict["D5"] = ButtonE4
        buttonDict["D6"] = ButtonE3
        buttonDict["D7"] = ButtonE2
        buttonDict["D8"] = ButtonE1
        buttonDict["E1"] = ButtonD8
        buttonDict["E2"] = ButtonD7
        buttonDict["E3"] = ButtonD6
        buttonDict["E4"] = ButtonD5
        buttonDict["E5"] = ButtonD4
        buttonDict["E6"] = ButtonD3
        buttonDict["E7"] = ButtonD2
        buttonDict["E8"] = ButtonD1
        buttonDict["F1"] = ButtonC8
        buttonDict["F2"] = ButtonC7
        buttonDict["F3"] = ButtonC6
        buttonDict["F4"] = ButtonC5
        buttonDict["F5"] = ButtonC4
        buttonDict["F6"] = ButtonC3
        buttonDict["F7"] = ButtonC2
        buttonDict["F8"] = ButtonC1
        buttonDict["G1"] = ButtonB8
        buttonDict["G2"] = ButtonB7
        buttonDict["G3"] = ButtonB6
        buttonDict["G4"] = ButtonB5
        buttonDict["G5"] = ButtonB4
        buttonDict["G6"] = ButtonB3
        buttonDict["G7"] = ButtonB2
        buttonDict["G8"] = ButtonB1
        buttonDict["H1"] = ButtonA8
        buttonDict["H2"] = ButtonA7
        buttonDict["H3"] = ButtonA6
        buttonDict["H4"] = ButtonA5
        buttonDict["H5"] = ButtonA4
        buttonDict["H6"] = ButtonA3
        buttonDict["H7"] = ButtonA2
        buttonDict["H8"] = ButtonA1
    }
    
    func setWhiteScoreViewArray() {
        whiteMaterialImages.append(whiteScoreIndex0)
        whiteMaterialImages.append(whiteScoreIndex1)
        whiteMaterialImages.append(whiteScoreIndex2)
        whiteMaterialImages.append(whiteScoreIndex3)
        whiteMaterialImages.append(whiteScoreIndex4)
        whiteMaterialImages.append(whiteScoreIndex5)
        whiteMaterialImages.append(whiteScoreIndex6)
        whiteMaterialImages.append(whiteScoreIndex7)
        whiteMaterialImages.append(whiteScoreIndex8)
        whiteMaterialImages.append(whiteScoreIndex9)
        whiteMaterialImages.append(whiteScoreIndex10)
        whiteMaterialImages.append(whiteScoreIndex11)
    }
    
    func setBlackScoreViewArray() {
        blackMaterialImages.append(blackScoreIndex0)
        blackMaterialImages.append(blackScoreIndex1)
        blackMaterialImages.append(blackScoreIndex2)
        blackMaterialImages.append(blackScoreIndex3)
        blackMaterialImages.append(blackScoreIndex4)
        blackMaterialImages.append(blackScoreIndex5)
        blackMaterialImages.append(blackScoreIndex6)
        blackMaterialImages.append(blackScoreIndex7)
        blackMaterialImages.append(blackScoreIndex8)
        blackMaterialImages.append(blackScoreIndex9)
        blackMaterialImages.append(blackScoreIndex10)
        blackMaterialImages.append(blackScoreIndex11)
    }
}

extension ViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return board.movesArr.count
  }
}

extension ViewController: NSTableViewDelegate {

  fileprivate enum CellIdentifiers {
    static let moveCell = "moveCellID"
    static let whiteCell = "whiteCellID"
    static let blackCell = "blackCellID"
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var text: String = ""
    var cellIdentifier: String = ""
    
    //setting the text varialbe for each column
    if tableColumn == tableView.tableColumns[0] {
      text = String(row+1)
      cellIdentifier = CellIdentifiers.moveCell
    } else if tableColumn == tableView.tableColumns[1] {
        text = board.movesArr[row].getWhiteMove()
        cellIdentifier = CellIdentifiers.whiteCell
    } else if tableColumn == tableView.tableColumns[2] {
        text = board.movesArr[row].getBlackMove()
        cellIdentifier = CellIdentifiers.blackCell
    }
    //setting the stringValue for each cell in column
    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
      cell.textField?.stringValue = text
      return cell
    }
    return nil
  }
}

extension ViewController: PopUpViewControllerDelegate {
    func setVariables(playingColor: String, stockfishStatus: Bool) {
        if playingColor == "white" {
            if stockfishStatus == true {
                board.enabledEngine(color: "black")
                engineStatus.stringValue = "Engine Playing as Black"
            }
        }
        else {
            if stockfishStatus == true {
                board.enabledEngine(color: "white")
                engineStatus.stringValue = "Engine Playing as White"
            }
        }
    }
}
