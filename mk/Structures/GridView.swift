//
//  GridView.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-26.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit

class GridView: UIView{
    /// Provides helper functions on top of UIView for drawing grid tiles
    class GridViewTile: UIView{
        /// Convenient way to set the color of the tile
        var tileColor = UIColor.red{
            didSet{
                self.backgroundColor = tileColor
            }
        }
        /// Set the opacity of the tile; hopefully to be used for animations at some point
        var opacity = 1.0{
            didSet{
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(CGFloat(opacity))
            }
        }
    }
    
    var grid: Grid
    var gridColor = UIColor.red
    /// The stack in which we're storing everything; indexed as [x][y]
    fileprivate var stack: UIStackView!
    
    init(frame: CGRect, grid: Grid) {
        self.grid = grid
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        var stacks = [UIStackView]()
        for _ in 0..<grid.width{
            var thisStack = [GridViewTile]()
            for _ in 0..<grid.height{
                let tile = GridViewTile(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                tile.tileColor = gridColor
                thisStack.append(tile)
            }
            let thisStackView = UIStackView(arrangedSubviews: thisStack)
            thisStackView.axis = .vertical
            thisStackView.distribution = .fillEqually
            thisStackView.spacing = 5.0
            stacks.append(thisStackView)
        }
        
        stack = UIStackView(arrangedSubviews: stacks)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        
        stack.frame = self.frame
        stack.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        iterationComplete()
        
        
        self.addSubview(stack)
    }
    
    convenience init(frame: CGRect, grid: Grid, color: UIColor){
        self.init(frame: frame, grid: grid)
        self.gridColor = color
    }
    
    /// Set a tile to live or not
    ///
    /// - Parameters:
    ///   - x: x-coordinate of tile
    ///   - y: y-coordinate of tile
    ///   - live: whether the tile is live or not
    func cell(x: Int, y: Int, live: Bool){
        guard let yAxis = stack.arrangedSubviews[x] as? UIStackView else{
            return
        }
        guard let tile = yAxis.arrangedSubviews[y] as? GridViewTile else{
            return
        }
        if live{
            tile.opacity = 1.0
        }else{
            tile.opacity = 0.0
        }
    }
    
    /// Run when a `Grid` iteration completes to keep the view in line with the model
    func iterationComplete(){
        for x in 0..<grid.width{
            for y in 0..<grid.height{
                cell(x: x, y: y, live: grid.cell(x: x, y: y))
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        guard let newGrid = aDecoder.value(forKey: "grid") as? Grid else{
            fatalError("init(coder:) failed to load a grid")
        }
        self.grid = newGrid
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(grid, forKey: "grid")
    }
}
