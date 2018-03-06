//
//  Grid.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-06.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import Foundation

class Grid{
    // MARK: Global Stuff
    /// The array of cells in the grid. Indexed as cells[x][y]
    var cells: [[Bool]]
    
    /// The width of the grid
    var width: Int{
        return cells.count
    }
    /// The height of the grid
    var height: Int{
        return cells[0].count
    }
    
    /// Iterate the grid using the standard rules of cellular automata/Conway's Game of Life
    func iterate(){
        
    }
    
    init?(x: Int, y: Int){
        if (x <= 0 || y <= 0){
            return nil
        }
        cells = [[Bool]](repeating: [Bool](repeating: false, count: y), count: x)
    }
    
    // MARK:- Cell Interactions
    
    /// Toggle the 'live' value of the cell at the given coordinates.
    ///
    /// - Parameters:
    ///   - x: x-coordinate to use. Zero-based.
    ///   - y: y-coordinate to use. Zero-based.
    func toggleCell(x: Int, y: Int){
        cells[x][y] = !cells[x][y]
    }
}
