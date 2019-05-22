//
//  BasicPiece.swift
//  Checkers
//
//  Created by Matthew Jednak on 2019-05-16.
//  Copyright © 2019 Checkers. All rights reserved.
//

import UIKit
import Foundation

class BasicPiece: Piece {
    
    override func draw() {
        var path = UIBezierPath()
        playerColor.setFill()
        let myRectangle = CGRect(x: self.X + 1, y: self.Y+1, width: self.size-2, height: self.size-2)
        path = UIBezierPath(ovalIn: myRectangle)
        path.fill()
    }
}
