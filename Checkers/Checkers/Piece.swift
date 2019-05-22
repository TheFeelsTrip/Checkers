//
//  Piece.swift
//  Checkers
//
//  Created by Matthew Jednak on 2019-05-16.
//  Copyright © 2019 Checkers. All rights reserved.
//

import Foundation
import UIKit

class Piece {
    var X: CGFloat
    var Y: CGFloat
    var size: CGFloat
    var playerColor: UIColor
    var playerNumber: Int
    var isKing: Bool
    
    init (X: CGFloat, Y: CGFloat, size: CGFloat, playerColor: UIColor, playerNumber: Int, isKing: Bool){
        self.playerColor = playerColor
        self.playerNumber = playerNumber
        self.X = X
        self.Y = Y
        self.size = size
        self.isKing = isKing
    }
    
    init() {
        self.playerColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 0)
        self.playerNumber = 0
        self.X = 0
        self.Y = 0
        self.size = 0
        self.isKing = false
    }
    
    func draw() {
        //will be overwritten
    }
}
