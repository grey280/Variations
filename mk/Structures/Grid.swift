//
//  Grid.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-06.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import Foundation

/// A grid on which Conway's Game of Life can play out
class Grid{
    // MARK: Variables
    /// The array of cells in the grid. Indexed as cells[x][y]
    private var cells: [[Bool]]
    
    /// Whether or not the grid wraps. If the grid doesn't wrap, then values outside the grid are treated as false.
    private var wrap: Bool
    
    /// The width of the grid
    var width: Int{
        return cells.count
    }
    /// The height of the grid
    var height: Int{
        return cells[0].count
    }
    
    /// The current active column
    var activeColumn: Int{
        return _active % width
    }
    
    /// The current active location
    private var _active = 0
    
    /// The current active row
    var activeRow: Int{
        return _active % height
    }
    
    // MARK: - Grid Interactions
    
    /// Iterate the grid using the standard rules of cellular automata/Conway's Game of Life
    func iterate(completion: (()->())? = nil){
        var newCells = [[Bool]](repeating: [Bool](repeating: false, count: height), count: width)
        for x in 0..<newCells.count{
            for y in 0..<newCells[x].count{
                newCells[x][y] = iteratedCellState(x: x, y: y)
            }
        }
        cells = newCells
        completion?()
    }
    
    /// Calculates the state of a cell on the next iteration
    ///
    /// - Parameters:
    ///   - x: x-coordinate to use. Zero-based.
    ///   - y: y-coordinate to use. Zero-based.
    /// - Returns: whether or not the cell will be 'alive' in the next iteration
    private func iteratedCellState(x: Int, y: Int) -> Bool{
        var neighborLiveCount = 0
        let currentState = cell(x: x, y: y)
        
        if cell(x: x-1, y: y-1){
            neighborLiveCount += 1
        }
        if cell(x: x, y: y-1){
            neighborLiveCount += 1
        }
        if cell(x: x+1, y: y-1){
            neighborLiveCount += 1
        }
        if cell(x: x-1, y: y){
            neighborLiveCount += 1
        }
        if cell(x: x+1, y: y){
            neighborLiveCount += 1
        }
        if cell(x: x-1, y: y+1){
            neighborLiveCount += 1
        }
        if cell(x: x, y: y+1){
            neighborLiveCount += 1
        }
        if cell(x: x+1, y: y+1){
            neighborLiveCount += 1
        }
        
        switch neighborLiveCount {
        case 0,1: // If they have fewer than two neighbors, they die of starvation
            return false
        case 2: // If they have two neighbors and are alive, they stay alive
            return currentState
        case 3: // If they have three neighbors, they either stay alive or one is 'born' there.
            return true
        default: // If they have more than three neighbors, they die of overpopulation
            return false
        }
        
    }
    
    /// Perform a 'tick' - move the active counter
    func tick(){
        _active = _active + 1
    }
    
    /// Build a grid of dimension x by y
    ///
    /// - Parameter x: width of the grid. Must be greater than 0.
    /// - Parameter y: height of the grid. Must be greater than 0.
    /// - Returns: an x by y grid filled with all inactive cell
    init?(x: Int, y: Int){
        if (x <= 0 || y <= 0){
            return nil
        }
        cells = [[Bool]](repeating: [Bool](repeating: false, count: y), count: x)
        
        wrap = true
    }
    
    /// Build a grid of dimension x by y with wrapping, if you'd like
    ///
    /// - Parameter x: width of the grid. Must be greater than 0.
    /// - Parameter y: height of the grid. Must be greater than 0.
    /// - Parameter wrap: whether or not the grid wraps
    /// - Returns: an x by y grid with or without wrapping, filled with all inactive cells
    init?(x: Int, y: Int, wrap doWrap: Bool){
        if (x <= 0 || y <= 0){
            return nil
        }
        cells = [[Bool]](repeating: [Bool](repeating: false, count: y), count: x)
        
        wrap = doWrap
    }
    
    /// Gets the parity of the grid as a whole
    ///
    /// - Returns: true if the grid has an odd number of active cells
    func parity() -> Bool{
        var activeCount = 0
        for outer in cells{
            for cell in outer{
                if cell{
                    activeCount = activeCount + 1
                }
            }
        }
        activeCount = activeCount % 2
        return activeCount == 0 ? false : true
    }
    
    /// Wrapper on `rowParity(_:)` to quickly access the parity of the current row
    ///
    /// - Returns: true if the current row has an odd number of active cells
    func rowParity() -> Bool{
        return rowParity(activeRow)
    }
    
    /// Gets the parity of a specific row
    ///
    /// - Parameter row: The row to check the parity of
    /// - Returns: true if the row has an odd number of active cells
    func rowParity(_ row: Int) -> Bool{
        var activeCount = 0
        for i in 0..<width{
            if cells[i][row]{
                activeCount = activeCount + 1
            }
        }
        activeCount = activeCount % 2
        return activeCount == 0 ? false : true
    }
    
    /// Wrapper on `columnParity(_:)` to quickly access the parity of the current column
    ///
    /// - Returns: true if the current column has an odd number of active cells
    func columnParity() -> Bool{
        return columnParity(activeColumn)
    }
    
    /// Gets the parity of a specific column
    ///
    /// - Parameter column: The column to check the parity of
    /// - Returns: true if the column has an odd number of active cells
    func columnParity(_ column: Int) -> Bool{
        var activeCount = 0
        for i in 0..<height{
            if cells[column][i]{
                activeCount = activeCount + 1
            }
        }
        activeCount = activeCount % 2
        return activeCount == 0 ? false : true
    }
    
    // MARK: - Cell Interactions
    
    /// Toggle the 'live' value of the cell at the given coordinates.
    ///
    /// - Parameters:
    ///   - x: x-coordinate to use. Zero-based.
    ///   - y: y-coordinate to use. Zero-based.
    func toggleCell(x: Int, y: Int){
        cells[x][y] = !cells[x][y]
    }
    
    /// Get the value of the cell at the given coordinates.
    ///
    /// - Parameters:
    ///   - x: x-coordinate to use. Zero-based.
    ///   - y: y-coordinate to use. Zero-based.
    /// - Returns: whether or not the cell at the given coordinates is 'alive'
    func cell(x: Int, y: Int) -> Bool{
        var nX = x, nY = y
        if wrap{
            if x>=width{
                nX = 0
            }
            if x<0{
                nX = width-1
            }
            if y>=height{
                nY = 0
            }
            if y<0{
                nY = height-1
            }
        }else{
            if (x>width || x<0 || y>height || y<0){
                return false
            }
        }
        return cells[nX][nY]
    }
    
    
    /// Set a cell to the specified 'life' status.
    ///
    /// - Parameters:
    ///   - x: x-coordinate to use. Zero-based.
    ///   - y: y-coordinate to use. Zero-based.
    ///   - alive: true if you're setting the cell to be 'alive', false otherwise
    func cell(x: Int, y: Int, alive: Bool){
        cells[x][y] = alive
    }
    
    // MARK: - Output functions
    /// Returns the current active column
    ///
    /// - Returns: an array of booleans consisting of the active states of the cells in the current column
    func column() -> [Bool]{
        return column(activeColumn)
    }
    
    /// Returns the column
    ///
    /// - Parameter col: the column to get
    /// - Returns: an array of booleans consisting of the active states of the cells in the column
    func column(_ col: Int) -> [Bool]{
        var output = [Bool]()
        for y in 0..<height{
            output.append(cells[col][y])
        }
        return output
    }
}
