//
//  GridView.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-26.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit

class GridView: UIView{
    class GridViewTile: UIView{
        var tileColor = UIColor.red{
            didSet{
                self.backgroundColor = tileColor
            }
        }
        var opacity = 1.0{
            didSet{
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(CGFloat(opacity))
            }
        }
    }
    
    var grid: Grid
    var gridColor = UIColor.red
    
    init(frame: CGRect, grid: Grid) {
        self.grid = grid
        super.init(frame: frame)
    }
    
    init(frame: CGRect, grid: Grid, color: UIColor){
        self.grid = grid
        self.gridColor = color
        super.init(frame: frame)
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
