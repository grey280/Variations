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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testGrid = GridView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2), grid: Grid(x: 10, y: 10)!)
        self.view.addSubview(testGrid)
        testGrid.backgroundColor = UIColor.clear
        testGrid.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

