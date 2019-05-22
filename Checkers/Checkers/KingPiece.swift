//
//  KingPiece.swift
//  Checkers
//
//  Created by Matthew Jednak on 2019-05-20.
//  Copyright © 2019 Checkers. All rights reserved.
//

import UIKit
import Foundation

class KingPiece: Piece {
    
    override func draw() {
        var path = UIBezierPath()
        //the piece circle
        playerColor.setFill()
        let myRectangle = CGRect(x: self.X + 1, y: self.Y+1, width: self.size-2, height: self.size-2)
        path = UIBezierPath(ovalIn: myRectangle)
        path.fill()
        
        //the king piece "crown"
        #colorLiteral(red: 0.9290281534, green: 0.8894444108, blue: 0, alpha: 1).setFill()
        let mySmallerRectangle = CGRect(x: self.X + 10, y: self.Y+10, width: self.size-20, height: self.size-20)
        path = UIBezierPath(ovalIn: mySmallerRectangle)
        path.fill()
    }
}
