//
//  SettingsViewController.swift
//  mk
//
//  Created by Grey Patterson on 2018-04-16.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit

/// View controller for handling settings
class SettingsViewController: UIViewController {

    /// Label showing the duration, in seconds, of each chord
    @IBOutlet weak var durationLabel: UILabel!
    
    /// Label showing the number of grids to have; minimum is 2, maximum is as yet undetermined
    @IBOutlet weak var gridsLabel: UILabel!
    /// Handle the 'done' button being pressed
    ///
    /// - Parameter sender: ignored
    @objc @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Prep for display; adds gesture recognizer and whatnot
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipDownGR = UISwipeGestureRecognizer(target: self, action: #selector(doneButton(_:)))
        swipDownGR.direction = .down
        self.view.addGestureRecognizer(swipDownGR)
    }
}
