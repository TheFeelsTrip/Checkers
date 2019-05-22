//
//  ViewController.swift
//  Checkers
//
//  Created by Matthew Jednak on 2019-05-12.
//  Copyright © 2019 Checkers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var checkerBoardView: CheckerBoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkerBoardView.buildCheckerBoard()
        checkerBoardView.setNeedsDisplay()
    }


}

