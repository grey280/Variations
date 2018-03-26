//
//  ViewController.swift
//  mk
//
//  Created by Grey Patterson on 2018-01-19.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var testGrid: GridView!
    
    @objc func handleTap(){
        testGrid.grid.iterate {
            testGrid.iterationComplete()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tempGrid = Grid(x: 10, y: 10)!
        for _ in 0..<15{
            tempGrid.cell(x: Int(arc4random_uniform(10)), y: Int(arc4random_uniform(10)), alive: true)
        }
        testGrid = GridView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2), grid: tempGrid)
        self.view.addSubview(testGrid)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

