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
    fileprivate var stack: UIStackView!
    
    init(frame: CGRect, grid: Grid) {
        self.grid = grid
        super.init(frame: frame)
        
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
        self.addSubview(stack)
    }
    
    convenience init(frame: CGRect, grid: Grid, color: UIColor){
        self.init(frame: frame, grid: grid)
        self.gridColor = color
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
