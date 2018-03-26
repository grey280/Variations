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
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(grid, forKey: "grid")
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
    
    fileprivate func drawGrid(){
        let path = UIBezierPath()
        path.lineWidth = 5.0
        
        UIColor.red.setStroke()
        UIColor.clear.setFill()
        
        for index in 1...Int(gridWidthMultiple) - 1{
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y:bounds.height)
            path.move(to: start)
            path.addLine(to: end)
        }
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        drawGrid()
        let path = UIBezierPath()
        path.lineWidth = 1.2
        UIColor.blue.setStroke()
        UIColor.clear.setFill()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 10, y: 10))
        path.stroke()
        
        print("Width: \(bounds.width) height: \(bounds.height)")
        print("Dimensions: \(grid.height) high by \(grid.width) wide")
    }
}
