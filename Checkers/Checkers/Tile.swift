//
//  Tile.swift
//  Checkers
//
//  Created by Matthew Jednak on 2019-05-12.
//  Copyright © 2019 Checkers. All rights reserved.
//
import UIKit
import Foundation

class Tile{
    var X: CGFloat
    var Y: CGFloat
    var size: CGFloat
    var backColor: UIColor
    
    init (X: CGFloat, Y: CGFloat, size: CGFloat, backColor: UIColor){
        self.X = X
        self.Y = Y
        self.size = size
        self.backColor = backColor
    }
    
    func draw(){
        var path = UIBezierPath()
        self.backColor.setFill()
        let mySquare = CGRect(x: self.X, y: self.Y, width: self.size, height: self.size)
        path = UIBezierPath(rect: mySquare)
        path.stroke()
        path.fill()
    }
}
