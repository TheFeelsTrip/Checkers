//
//  DrawingView.swift
//  Test2
//
//  Created by Sandy on 2019-05-02.
//  Copyright © 2019 Sandy. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    // Size of the grid
    var gridSize:Int!
    // Array of Squares
    var theSquares:[Square]!
    // we gonna hide a diamond
    var diamond:SquareWithDiamond!
    
    // TODO:
    // Draw the diamond (if it exists)
    // Draw all the Squares in the array
    override func draw(_ rect: CGRect) {
        diamond.draw()
        for square in theSquares{
            square.draw()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         Check if the location of the touch is in the diamond square
         
         Check if the location of the touch is in any square is in the array:
         If it is:
         Check if the square is clickable:
         If it is:
         If diamond is not in this square...
         Add a "SquareWithX" that is not clickable, linethickness 1,
         to the array with the same dimensions and location as
         the square clicked
         end if
         Remove the clicked square from the array
         
         If diamond has been found, set all square properties 'isClickable'
         to false
         
         Force a redraw
         */
        let point:CGPoint! = touches.first?.location(in: self)
        var counter = 0
        
        for square in theSquares{
            
            if ((point.x > square.X) && (point.x < square.X+square.size) && (point.y > square.Y) && (point.y < square.Y+square.size)){
                if (square.isClickable){
                    //if square with diamond position matches square clicked
                    if (square.X == diamond.X && square.Y == diamond.Y){
                        theSquares.remove(at: counter)
                        for square in theSquares{
                            square.isClickable = false
                        }
                    }
                        //replace squareWithToken with squareWithX
                    else{
                        var temp = SquareWithX(X: square.X, Y: square.Y, size: square.size, isClickable: false, lineThickness: 1)
                        theSquares.append(temp)
                        theSquares.remove(at: counter)
                    }
                }
                break
            }
            counter = counter + 1
        }
        
        setNeedsDisplay()
        
    }
    
    func buildGridSquares() {
        // Constants
        let offset = 10
        let width = Int(self.bounds.width) - offset*2
        let height = Int(self.bounds.height) - offset*2
        let cellSize:Int!
        
        // Make a new array everytime this method is called
        self.theSquares = [Square]()
        
        // define the hidden diamond spot
        let diamondRow:Int = Int(arc4random_uniform(UInt32(gridSize)))
        let diamondCol:Int = Int(arc4random_uniform(UInt32(gridSize)))
        
        
        // Determine the cellSize:
        //      It is the width or height divided by self.gridSize
        //          ... use which ever is smaller
        
        if(width/self.gridSize < height/self.gridSize){
            cellSize = width/self.gridSize
        }
        else{
            cellSize = height/self.gridSize
        }
        
        
        
        // Create the diamond square at the correct position:
        //      It's dimensions should be size x size and it's location should be:
        //          X = offset + cellSize*col
        //          Y = offset + cellSize*row
        self.diamond = SquareWithDiamond(X: CGFloat(offset + (cellSize*diamondCol)), Y: CGFloat(offset + (cellSize*diamondRow)), size: CGFloat(cellSize))
        
        for row in 0..<gridSize {
            for col in 0..<self.gridSize {
                var temp = SquareWithToken(X: CGFloat(offset + (cellSize*col)), Y: CGFloat(offset + (cellSize*row)), size: CGFloat(cellSize), isClickable: true, colour: UIColor.red)
                theSquares.append(temp)
                
            }
        }
        
    }
}
