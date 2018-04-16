//
//  GridView.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-26.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit

/// Display a `Grid`
class GridView: UIView{
    /// Global constants for the grid view stuff
    struct GVConstants{
        /// Color to highlight rows/columns with
        static let highlightColor = UIColor.yellow.withAlphaComponent(0.5)
        /// Opacity level to use when a tile is being displayed
        static let opacityLevelOn = 0.7
        /// Opacity level to use when a tile is not being displayed
        static let opacityLevelOff = 0.0
        /// Duration of animations
        static let animationDuration = 0.2
    }
    
    /// Provides helper functions on top of UIView for drawing grid tiles
    class GridViewTile: UIView{
        /// Convenient way to set the color of the tile
        var tileColor = UIColor.red{
            didSet{
                self.backgroundColor = tileColor
            }
        }
        /// Set the opacity of the tile; hopefully to be used for animations at some point
        var opacity = GVConstants.opacityLevelOn{
            didSet{
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(CGFloat(opacity))
            }
        }
    }
    
    /// The `Grid` used as the backing model
    var grid: Grid
    /// The color of the cells in the grid
    var gridColor = UIColor.red{
        didSet{
            for x in 0..<grid.width{
                for y in 0..<grid.height{
                    cell(x: x, y: y, color: gridColor)
                }
            }
        }
    }
    /// The stack in which we're storing everything; indexed as [x][y]
    fileprivate var stack: UIStackView!
    
    /// Create a GridView
    ///
    /// - Parameters:
    ///   - frame: the frame in which the GridView will be displayed
    ///   - grid: an instance of `Grid` to be used as the model; will automatically fill settings based on that
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
                tile.isOpaque = false
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
    
    /// Create a GridView with a given color
    ///
    /// - Parameters:
    ///   - frame: the frame in which the GridView will be displayed
    ///   - grid: an instance of `Grid` to be used as the model; will automatically fill settings based on that
    ///   - color: the color that all the tiles should have
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
        guard let tile = yAxis.arrangedSubviews[grid.height-y-1] as? GridViewTile else{
            return
        }
        UIView.animate(withDuration: GVConstants.animationDuration) {
            if live{
                tile.opacity = GVConstants.opacityLevelOn
            }else{
                tile.opacity = GVConstants.opacityLevelOff
            }
        }
        
    }
    
    /// Set a tile's background color
    ///
    /// - Parameters:
    ///   - x: x-coordinate of tile
    ///   - y: y-coordinate of tile
    ///   - color: color to set the tile to
    func cell(x: Int, y: Int, color: UIColor){
        guard let yAxis = stack.arrangedSubviews[x] as? UIStackView else{
            return
        }
        guard let tile = yAxis.arrangedSubviews[grid.height-y-1] as? GridViewTile else{
            return
        }
        tile.tileColor = color
        UIView.animate(withDuration: GVConstants.animationDuration) {
            if self.grid.cell(x: x, y: y){
                tile.opacity = GVConstants.opacityLevelOn
            }else{
                tile.opacity = GVConstants.opacityLevelOff
            }
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
    
    
    /// Initialize from an encoded version
    ///
    /// - Parameter aDecoder: an instance of `NSCoder` to use for decoding
    required init?(coder aDecoder: NSCoder) {
        guard let newGrid = aDecoder.value(forKey: "grid") as? Grid else{
            fatalError("init(coder:) failed to load a grid")
        }
        self.grid = newGrid
        super.init(coder: aDecoder)
    }
    
    /// Encode the GridView; required by UIKit
    ///
    /// - Parameter aCoder: an instance of `NSCoder` to use for encoding
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(grid, forKey: "grid")
    }
}
