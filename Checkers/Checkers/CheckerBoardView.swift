//
//  DrawingView.swift
//  Test2
//
//  Created by Sandy on 2019-05-02.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit
import Foundation

class CheckerBoardView: UIView {
    // Size of the grid
    var gridSize:Int = 8
    // Array of tiles
    var tiles:[Tile]!
    // Array of checker pieces
    var pieces:[Piece]!
    
    // Colors used
    var whiteBoardColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var darkBoardColor: UIColor = #colorLiteral(red: 0, green: 0.4114221931, blue: 0.04984205961, alpha: 1)
    var player1Color: UIColor = #colorLiteral(red: 0.9660390019, green: 0, blue: 0, alpha: 1)
    var player2Color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var selectedTileColor: UIColor = #colorLiteral(red: 0.72188133, green: 0.4770253301, blue: 0, alpha: 1)
    var availableMoveColor: UIColor = #colorLiteral(red: 0, green: 0.9071852565, blue: 0.02439256757, alpha: 1)
    
    /////////////////////////////////////////////////////
    //              Game Variables                     //
    /////////////////////////////////////////////////////
    // used to determine when a player gets a king
    // i.e. the top and bottom rows
    var p1KingRowY:CGFloat = 318
    var p2KingRowY:CGFloat = 10
    var selectedPiece:Piece!
    var currentPlayer: Int = 1
    
    //placeholder variables to store the possible pieces to eat
    var tLeftPieceToEat = Piece()
    var tRightPieceToEat = Piece()
    var bLeftPieceToEat = Piece()
    var bRightPieceToEat = Piece()
    
    // TODO:
    // Draw all the tiles and pieces in the array
    override func draw(_ rect: CGRect) {
        for tile in tiles{
            tile.draw()
        }
        for piece in pieces{
            piece.draw()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let point:CGPoint! = touches.first?.location(in: self)
        var counter = 0
        
        for tile in tiles{
            
            if (tile.backColor == selectedTileColor){
                tile.backColor = darkBoardColor
            }
            
            if ((point.x > tile.X) && (point.x < tile.X + tile.size) && (point.y > tile.Y) && (point.y < tile.Y + tile.size)){
                
                if (tile.backColor == availableMoveColor){
                    movePiece(piece: selectedPiece, tile: tile)
                }
                
                //reset the placeholder variables
                tLeftPieceToEat = Piece()
                tRightPieceToEat = Piece()
                bLeftPieceToEat = Piece()
                bRightPieceToEat = Piece()
                
                for tile in tiles {
                    if (tile.backColor == availableMoveColor){
                        tile.backColor = darkBoardColor
                    }
                }
                
                if (tile.backColor == darkBoardColor){
                    if ((point.x > tile.X) && (point.x < tile.X + tile.size) && (point.y > tile.Y) && (point.y < tile.Y + tile.size)){
                        
                        for piece in pieces{
                            if (piece.X == tile.X && piece.Y == tile.Y){
                                if (piece.playerNumber == currentPlayer){
                                    tile.backColor = selectedTileColor
                                    selectedPiece = piece
                                    if (piece.isKing){
                                        checkMovesKing(piece: piece, tLeft: false, tRight: false, bLeft: false, bRight: false, depth: 0)
                                    }
                                    else{
                                        checkMoves(piece: piece, left: false, right: false, depth: 0)
                                    }
                                }
                            }
                        }
                    }
                }
                counter = counter + 1
            }
        }
        //checkMoves()
        crownKingPiece()
        setNeedsDisplay()
    }
    
    func crownKingPiece() {
        var pCounter = 0
        for piece in pieces{
            if(piece.isKing == false){
                if(piece.Y == p1KingRowY && piece.playerNumber == 1){
                    var king = KingPiece(X: piece.X, Y: piece.Y, size: piece.size, playerColor: piece.playerColor, playerNumber: piece.playerNumber, isKing: true)
                    pieces.remove(at: pCounter)
                    pieces.append(king)
                    break
                }
                else if(piece.Y == p2KingRowY && piece.playerNumber == 2) {
                    var king = KingPiece(X: piece.X, Y: piece.Y, size: piece.size, playerColor: piece.playerColor, playerNumber: piece.playerNumber, isKing: true)
                    pieces.remove(at: pCounter)
                    pieces.append(king)
                    break
                }
            }
            pCounter = pCounter + 1
        }
    }
    
    func movePiece(piece: Piece, tile: Tile){
        
        //to determine which piece to each
        //the piece to the top left diagonal
        if(piece.X > tile.X && piece.Y < tile.Y){
            for i in 0..<pieces.count{
                if (pieces[i].X == tLeftPieceToEat.X && pieces[i].Y == tLeftPieceToEat.Y){
                    pieces.remove(at: i)
                    break
                }
            }
        }
        //the piece to the top right diagonal
        else if (piece.X < tile.X && piece.Y < tile.Y){
            for i in 0..<pieces.count{
                if (pieces[i].X == tRightPieceToEat.X && pieces[i].Y == tRightPieceToEat.Y){
                    pieces.remove(at: i)
                    break
                }
            }
        }
        else if (piece.X > tile.X && piece.Y > tile.Y){
            for i in 0..<pieces.count{
                if (pieces[i].X == bLeftPieceToEat.X && pieces[i].Y == bLeftPieceToEat.Y){
                    pieces.remove(at: i)
                    break
                }
            }
        }
        else{
            for i in 0..<pieces.count{
                if (pieces[i].X == bRightPieceToEat.X && pieces[i].Y == bRightPieceToEat.Y){
                    pieces.remove(at: i)
                    break
                }
            }
        }
        
        //move the piece to the new location
        piece.X = tile.X
        piece.Y = tile.Y
        
        //switch player turns
        if (currentPlayer == 1){
            currentPlayer = 2
        }
        else{
            currentPlayer = 1
        }
    }
    
    func checkMoves(piece: Piece, left: Bool, right: Bool, depth: Int) {
        var leftBlocked = left
        var rightBlocked = right
        var counter = depth
        
        for tile in tiles{
            //check moves for player 1
            if (currentPlayer == 1){
                //check for left tile move
                if (!leftBlocked){
                    if (tile.X == piece.X - piece.size && tile.Y == piece.Y + piece.size){
                        for p in pieces{
                            if (p.X == piece.X - piece.size && p.Y == piece.Y + piece.size){
                                leftBlocked = true
                                counter = counter + 1
                                if (counter <= 1 && p.playerNumber != currentPlayer){
                                    tLeftPieceToEat = p
                                    checkMoves(piece: p, left: false, right: true, depth: counter)
                                    continue
                                }
                            }
                        }
                        if (!leftBlocked){
                            tile.backColor = availableMoveColor
                        }
                    }
                }
                counter = depth
                //check for right tile move
                if (!rightBlocked){
                    if (tile.X == piece.X + piece.size && tile.Y == piece.Y + piece.size){
                        for p in pieces{
                            if (p.X == piece.X + piece.size && p.Y == piece.Y + piece.size){
                                rightBlocked = true
                                counter = counter + 1
                                if (counter <= 1 && p.playerNumber != currentPlayer){
                                    tRightPieceToEat = p
                                    checkMoves(piece: p, left: true, right: false, depth: counter)
                                    continue
                                }
                            }
                        }
                        if (!rightBlocked){
                            tile.backColor = availableMoveColor
                        }
                    }
                }
            }
            //check moves for player 2
            else {
                if (!leftBlocked){
                    if (tile.X == piece.X - piece.size && tile.Y == piece.Y - piece.size){
                        for p in pieces{
                            if (p.X == piece.X - piece.size && p.Y == piece.Y - piece.size){
                                leftBlocked = true
                                counter = counter + 1
                                if (counter <= 1 && p.playerNumber != currentPlayer){
                                    bLeftPieceToEat = p
                                    checkMoves(piece: p, left: false, right: true, depth: counter)
                                    continue
                                }
                            }
                        }
                        if (!leftBlocked){
                            tile.backColor = availableMoveColor
                        }
                    }
                }
                counter = depth
                if (!rightBlocked){
                    if (tile.X == piece.X + piece.size && tile.Y == piece.Y - piece.size){
                        for p in pieces{
                            if (p.X == piece.X + piece.size && p.Y == piece.Y - piece.size){
                                rightBlocked = true
                                counter = counter + 1
                                if (counter <= 1 && p.playerNumber != currentPlayer){
                                    bRightPieceToEat = p
                                    checkMoves(piece: p, left: true, right: false, depth: counter)
                                    continue
                                }
                            }
                        }
                        if (!rightBlocked){
                            tile.backColor = availableMoveColor
                        }
                    }
                }
            }
        }
    }
    
    func checkMovesKing(piece: Piece, tLeft: Bool, tRight: Bool, bLeft: Bool, bRight: Bool, depth: Int) {
        var tLeftBlocked = tLeft
        var tRightBlocked = tRight
        var bLeftBlocked = bLeft
        var bRightBlocked = bRight
        var counter = depth
        
        for tile in tiles{
            //check for left tile move
            if (!tLeftBlocked){
                if (tile.X == piece.X - piece.size && tile.Y == piece.Y + piece.size){
                    for p in pieces{
                        if (p.X == piece.X - piece.size && p.Y == piece.Y + piece.size){
                            tLeftBlocked = true
                            counter = counter + 1
                            if (counter <= 1 && p.playerNumber != currentPlayer){
                                tLeftPieceToEat = p
                                checkMovesKing(piece: p, tLeft: false, tRight: true, bLeft: true, bRight: true, depth: counter)
                                continue
                            }
                        }
                    }
                    if (!tLeftBlocked){
                        tile.backColor = availableMoveColor
                    }
                }
            }
            counter = depth
            //check for right tile move
            if (!tRightBlocked){
                if (tile.X == piece.X + piece.size && tile.Y == piece.Y + piece.size){
                    for p in pieces{
                        if (p.X == piece.X + piece.size && p.Y == piece.Y + piece.size){
                            tRightBlocked = true
                            counter = counter + 1
                            if (counter <= 1 && p.playerNumber != currentPlayer){
                                tRightPieceToEat = p
                               checkMovesKing(piece: p, tLeft: true, tRight: false, bLeft: true, bRight: true, depth: counter)
                                continue
                            }
                        }
                    }
                    if (!tRightBlocked){
                        tile.backColor = availableMoveColor
                    }
                }
            }
            if (!bLeftBlocked){
                if (tile.X == piece.X - piece.size && tile.Y == piece.Y - piece.size){
                    for p in pieces{
                        if (p.X == piece.X - piece.size && p.Y == piece.Y - piece.size){
                            bLeftBlocked = true
                            counter = counter + 1
                            if (counter <= 1 && p.playerNumber != currentPlayer){
                                bLeftPieceToEat = p
                               checkMovesKing(piece: p, tLeft: true, tRight: true, bLeft: false, bRight: true, depth: counter)
                                continue
                            }
                        }
                    }
                    if (!bLeftBlocked){
                        tile.backColor = availableMoveColor
                    }
                }
            }
            counter = depth
            if (!bRightBlocked){
                if (tile.X == piece.X + piece.size && tile.Y == piece.Y - piece.size){
                    for p in pieces{
                        if (p.X == piece.X + piece.size && p.Y == piece.Y - piece.size){
                            bRightBlocked = true
                            counter = counter + 1
                            if (counter <= 1 && p.playerNumber != currentPlayer){
                                bRightPieceToEat = p
                                checkMovesKing(piece: p, tLeft: true, tRight: true, bLeft: true, bRight: false, depth: counter)
                                continue
                            }
                        }
                    }
                    if (!bRightBlocked){
                        tile.backColor = availableMoveColor
                    }
                }
            }
        }
    }
    
    func buildCheckerBoard() {
        // Constants
        let offset = 10
        let width = Int(self.bounds.width) - offset*2
        let height = Int(self.bounds.height) - offset*2
        let cellSize:Int!
        
        // Make a new array eve     rytime this method is called
        self.tiles = [Tile]()
        self.pieces = [Piece]()
        
        // Determine the cellSize:
        if(width/self.gridSize < height/self.gridSize){
            cellSize = width/self.gridSize
        }
        else{
            cellSize = height/self.gridSize
        }
        
        var color = whiteBoardColor
        var counter = 0
        
        for row in 0..<gridSize {
            for col in 0..<self.gridSize {
                var temp = Tile(X: CGFloat(offset + (cellSize*col)), Y: CGFloat(offset + (cellSize*row)), size: CGFloat(cellSize), backColor: color)
                tiles.append(temp)
                
                //add pieces to board
                if (color == darkBoardColor){
                    //white pieces
                    if (counter < 12){
                        var checker = BasicPiece(X: CGFloat(offset + (cellSize*col)), Y: CGFloat(offset + (cellSize*row)), size: CGFloat(cellSize), playerColor: player1Color, playerNumber: 1, isKing: false)
                        pieces.append(checker)
                    }
                    
                    //black pieces
                    if (counter > 19){
                        var checker = BasicPiece(X: CGFloat(offset + (cellSize*col)), Y: CGFloat(offset + (cellSize*row)), size: CGFloat(cellSize), playerColor: player2Color, playerNumber: 2, isKing: false)
                        pieces.append(checker)
                    }
                    
                    counter = counter + 1
                }
                
                if(col < self.gridSize-1){
                    if (color == whiteBoardColor){
                        color = darkBoardColor
                    }
                    else{
                        color = whiteBoardColor
                    }
                }
            }
        }
    }
}
