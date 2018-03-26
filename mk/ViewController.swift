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
    @IBOutlet weak var testGrid: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testGrid = GridView(frame: testGrid.frame, grid: Grid(x: 10, y: 10)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

