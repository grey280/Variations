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
    
    /// Hide the status bar; it doesn't look super good with it displayed, after all.
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    /// The list of grids that will be displayed on-screen
    var grids = [GridView]()
    
    // Test code
    var testGrid: GridView!
    var testGrid2: GridView!
    
    // Test code
    @objc func handleTap(){
        iterate()
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
    
    /// Iterate all grids at once, including randomization
    func iterate(){
        // tweak a couple of the grids
        let random1 = Int(arc4random_uniform(UInt32(grids.count)))
        let random2 = Int(arc4random_uniform(UInt32(grids.count)))
        let random1x = Int(arc4random_uniform(UInt32(grids[random1].grid.width)))
        let random1y = Int(arc4random_uniform(UInt32(grids[random1].grid.height)))
        let random2x = Int(arc4random_uniform(UInt32(grids[random2].grid.width)))
        let random2y = Int(arc4random_uniform(UInt32(grids[random2].grid.height)))
        grids[random1].grid.toggleCell(x: random1x, y: random1y)
        grids[random2].grid.toggleCell(x: random2x, y: random2y)
        
        // ... and then run the iteration
        for gridView in grids{
            gridView.grid.iterate {
                gridView.iterationComplete()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Testing code!
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
}

