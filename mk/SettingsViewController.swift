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
    // MARK: Variables

    /// Label showing the duration, in seconds, of each chord
    @IBOutlet weak var durationLabel: UILabel!
    
    /// Label showing the number of grids to have; minimum is 2, maximum is as yet undetermined
    @IBOutlet weak var gridsLabel: UILabel!
    
    /// Whether or not to use all the chords or just the I IV V I set
    @IBOutlet weak var chordSwitch: UISwitch!
    /// Stepper for inputting the duration of each chord
    @IBOutlet weak var durationStepper: UIStepper!
    /// Stepper used for inputting the number of grids to use
    @IBOutlet weak var gridStepper: UIStepper!
    
    // MARK: - Functions
    /// Triggered when the duration stepper is used
    ///
    /// - Parameter sender: durationStepper
    @IBAction func durationStepped(_ sender: UIStepper) {
        UserDefaults.standard.set(sender.value, forKey: constants.defaults.chordDuration)
        durationLabel.text = "\(sender.value)"
    }
    
    /// Triggered when the grid stepper is used
    ///
    /// - Parameter sender: gridStepper
    @IBAction func gridStepped(_ sender: UIStepper) {
        UserDefaults.standard.set(Int(sender.value), forKey: constants.defaults.gridCount)
        gridsLabel.text = "\(Int(sender.value))"
    }
    
    /// Handle the 'done' button being pressed
    ///
    /// - Parameter sender: ignored
    @objc @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Setup
    
    /// Prep for display; adds gesture recognizer, pull current settings and fill data to be accurate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the current grid count
        var gridCount = UserDefaults.standard.integer(forKey: constants.defaults.gridCount)
        if gridCount == 0{
            UserDefaults.standard.set(constants.defaultValues.gridCount, forKey: constants.defaults.gridCount)
            gridCount = constants.defaultValues.gridCount
        }
        gridsLabel.text = "\(gridCount)"
        gridStepper.value = Double(gridCount)
        
        var timeInterval = UserDefaults.standard.double(forKey: constants.defaults.chordDuration)
        if timeInterval == 0{
            UserDefaults.standard.set(constants.defaultValues.chordDuration, forKey: constants.defaults.chordDuration)
            timeInterval = constants.defaultValues.chordDuration
        }
        durationStepper.value = timeInterval
        durationLabel.text = "\(timeInterval)"
        
        
        let swipDownGR = UISwipeGestureRecognizer(target: self, action: #selector(doneButton(_:)))
        swipDownGR.direction = .down
        self.view.addGestureRecognizer(swipDownGR)
    }
}
