//
//  Grid.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-06.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import Foundation

class Grid{
    /// The array of cells in the grid. Indexed as cells[x][y]
    var cells: [[Cell]]
    
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
        cells = [[Cell]](repeating: [Cell](repeating: Cell(), count: y), count: x)
    }
}
