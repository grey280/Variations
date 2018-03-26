//
//  GridView.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-26.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit

class GridView: UIView{
    var grid: Grid
    
    init(frame: CGRect, grid: Grid) {
        self.grid = grid
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let newGrid = aDecoder.value(forKey: "grid") as? Grid else{
            fatalError("init(coder:) failed to load a grid")
        }
        self.grid = newGrid
        super.init(coder: aDecoder)
    }
    
    fileprivate var gridWidthMultiple: CGFloat{
        return CGFloat(grid.width)
    }
    fileprivate var gridHeightMultiple : CGFloat{
        return CGFloat(grid.height)
    }
    
    fileprivate var gridWidth: CGFloat{
        return bounds.width/CGFloat(gridWidthMultiple)
    }
    
    fileprivate var gridHeight: CGFloat{
        return bounds.height/CGFloat(gridHeightMultiple)
    }
    
    fileprivate var gridCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    fileprivate func drawGrid(){
        let path = UIBezierPath()
        path.lineWidth = 5.0
        
        UIColor.black.setStroke()
        
        for index in 1...Int(gridWidthMultiple) - 1{
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y:bounds.height)
            path.move(to: start)
            path.addLine(to: end)
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawGrid()
    }
}
