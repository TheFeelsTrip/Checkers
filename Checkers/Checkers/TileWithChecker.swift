//
//  TileWithChecker.swift
//  Checkers
//
//  Created by Matthew Jednak on 2019-05-13.
//  Copyright © 2019 Checkers. All rights reserved.
//

import Foundation
import UIKit

class TileWithChecker: Tile {
    
    var playerColor: UIColor
    var playerNumber: Int
    
    init (X: CGFloat, Y: CGFloat, size: CGFloat, playerColor: UIColor, playerNumber: Int){
        self.playerColor = playerColor
        self.playerNumber = playerNumber
        super.init(X: X, Y: Y, size: size)
        self.X = X
        self.Y = Y
        self.size = size
    }
    
    override func draw() {
        super.draw()
        var path = UIBezierPath()
        playerColor.setFill()
        let myRectangle = CGRect(x: self.X + 1, y: self.Y+1, width: self.size-2, height: self.size-2)
        path = UIBezierPath(ovalIn: myRectangle)
        path.fill()
    }
}
