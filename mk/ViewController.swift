//
//  ViewController.swift
//  mk
//
//  Created by Grey Patterson on 2018-01-19.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool{ // Hide the status bar, it looks dumb otherwise
        return true
    }
    
    var testGrid: GridView!
    var testGrid2: GridView!
    
    @objc func handleTap(){
        testGrid.grid.iterate {
            testGrid.iterationComplete()
        }
        testGrid2.grid.iterate {
            testGrid2.iterationComplete()
        }
    }
    
    /// Generate a random square grid with the given dimension
    ///
    /// - Parameter dimension: the size of the grid to generate
    /// - Returns: an instance of `Grid` with a randomly-generated beginning state
    private func randomGrid(_ dimension: Int) -> Grid{
        let tempGrid = Grid(x: dimension, y: dimension)!
        for _ in 0..<Int(1.5*dimension){
            tempGrid.cell(x: Int(arc4random_uniform(UInt32(dimension))), y: Int(arc4random_uniform(UInt32(dimension))), alive: true)
        }
        return tempGrid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempGrid = randomGrid(10)
        let tempGrid2 = randomGrid(8)
        testGrid = GridView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2), grid: tempGrid)
        testGrid2 = GridView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2), grid: tempGrid2)
        testGrid2.gridColor = UIColor.blue
        self.view.addSubview(testGrid)
        self.view.addSubview(testGrid2)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

