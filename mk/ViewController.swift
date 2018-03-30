//
//  ViewController.swift
//  mk
//
//  Created by Grey Patterson on 2018-01-19.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit
import AudioKit

/// The main ViewController for everything; honestly this is gonna be a Massive View Controller deal probably, but I'm okay with that
class ViewController: UIViewController {
    
    /// Hide the status bar; it doesn't look super good with it displayed, after all.
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    /// The list of grids that will be displayed on-screen
    var grids = [GridView]()
    
    // Test code
    /// Iterate the grids when the screen is tapped
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
        iterate(2)
    }
    
    
    /// Iterate all grids at once, including the given number of randomly flipped tiles
    ///
    /// - Parameter randoms: the number of tiles to flip (random grid, random tile, each time)
    func iterate(_ randoms: Int){
        for gridView in grids{
            gridView.grid.iterate{
                gridView.iterationComplete()
            }
        }
        
        for _ in 0..<randoms{
            let gridTweak = Int(arc4random_uniform(UInt32(grids.count)))
            let gridX = Int(arc4random_uniform(UInt32(grids[gridTweak].grid.width)))
            let gridY = Int(arc4random_uniform(UInt32(grids[gridTweak].grid.height)))
            grids[gridTweak].grid.toggleCell(x: gridX, y: gridY)
        }
    }
    
    /// Generates a random color
    ///
    /// - Returns: a randomized UIColor
    private func randomColor() -> UIColor{
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    /// Wrapper for `buildGrids`
    @objc private func resetGrids(){
        buildGrids(8)
    }
    
    /// Build the given number of grids
    ///
    /// - Parameter number: number of grids to build
    private func buildGrids(_ number: Int){
        for i in 0..<grids.count{
            grids[i].removeFromSuperview()
        }
        for _ in 0..<number{
            let tempGrid = randomGrid(Int(arc4random_uniform(25))+1)
            let tempGridView = GridView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), grid: tempGrid)
            tempGridView.gridColor = randomColor()
            grids.append(tempGridView)
            self.view.addSubview(tempGridView)
        }
    }
    
    /// Set up the view to run
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildGrids(8)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.resetGrids))
        swipeRecognizer.direction = .down
        self.view.addGestureRecognizer(swipeRecognizer)
    }
}

