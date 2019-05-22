//
//  TileWithKing.swift
//  Checkers
//
//  Created by Matthew Jednak on 2019-05-13.
//  Copyright © 2019 Checkers. All rights reserved.
//

import Foundation
import UIKit

class TileWithKing: Tile {
    
    private var teamColor: UIColor
    
    init (X: CGFloat, Y: CGFloat, size: CGFloat, teamColor: UIColor){
        self.teamColor = teamColor
        super.init(X: X, Y: Y, size: size)
        self.X = X
        self.Y = Y
        self.size = size
    }
    
    //TODO: Find a way to distinguish king from normal piece
    override func draw() {
        super.draw()
        var path = UIBezierPath()
        teamColor.setFill()
        let myRectangle = CGRect(x: self.X + 1, y: self.Y+1, width: self.size-2, height: self.size-2)
        path = UIBezierPath(ovalIn: myRectangle)
        path.fill()
    }
}
