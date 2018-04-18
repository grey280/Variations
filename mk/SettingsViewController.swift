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
    
    /// Label showing the number of cells to randomly toggle per tap
    @IBOutlet weak var randomLabel: UILabel!
    
    /// Whether or not to use all the chords or just the I IV V I set
    @IBOutlet weak var chordSwitch: UISwitch!
    /// Stepper for inputting the duration of each chord
    @IBOutlet weak var durationStepper: UIStepper!
    /// Stepper used for inputting the number of grids to use
    @IBOutlet weak var gridStepper: UIStepper!
    /// Stepper used for controlling the number of random cells per iteration
    @IBOutlet weak var randomStepper: UIStepper!
    
    // MARK: - Functions
    /// Handle the 'use all chords' switch being tapped
    ///
    /// - Parameter sender: `chordSwitch`
    @IBAction func chordSwitched(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: constants.defaults.allChordsEnabled)
    }
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
    
    /// Handle one of the default configurations being chosen
    ///
    /// - Parameter sender: the UISegmentedControl containing the configuration profiles
    @IBAction func defaultChosen(_ sender: UISegmentedControl) {
        var gCount: Int
        var cSwitch: Bool
        var dTime: Double
        var rCount: Int
        switch sender.selectedSegmentIndex{
        case 0:
            gCount = constants.configs.meditate.gridCount
            cSwitch = constants.configs.meditate.allChordsEnabled
            dTime = constants.configs.meditate.chordDuration
            rCount = constants.configs.meditate.randomCount
        case 1:
            gCount = constants.configs.original.gridCount
            cSwitch = constants.configs.original.allChordsEnabled
            dTime = constants.configs.original.chordDuration
            rCount = constants.configs.original.randomCount
        case 2:
            gCount = constants.configs.energy.gridCount
            cSwitch = constants.configs.energy.allChordsEnabled
            dTime = constants.configs.energy.chordDuration
            rCount = constants.configs.energy.randomCount
        default:
            return
        }
        UserDefaults.standard.set(gCount, forKey: constants.defaults.gridCount)
        gridsLabel.text = "\(gCount)"
        gridStepper.value = Double(gCount)
        UserDefaults.standard.set(cSwitch, forKey: constants.defaults.allChordsEnabled)
        chordSwitch.setOn(cSwitch, animated: true)
        UserDefaults.standard.set(dTime, forKey: constants.defaults.chordDuration)
        durationLabel.text = "\(dTime)"
        durationStepper.value = dTime
        UserDefaults.standard.set(rCount, forKey: constants.defaults.randomCount)
        UserDefaults.standard.set(true, forKey: constants.defaults.randomCountInitalized)
        randomLabel.text = "\(rCount)"
        randomStepper.value = Double(rCount)
    }
    
    /// Handle the 'random cells' stepper being used
    ///
    /// - Parameter sender: `randomStepper`
    @IBAction func randomStepped(_ sender: UIStepper) {
        UserDefaults.standard.set(Int(sender.value), forKey: constants.defaults.randomCount)
        UserDefaults.standard.set(true, forKey: constants.defaults.randomCountInitalized)
        randomLabel.text = "\(Int(sender.value))"
    }
    
    // MARK: - Setup
    
    /// Use the status bar with the light text
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    
    /// Disable rotation on this view
    override var shouldAutorotate: Bool{
        return false
    }
    
    /// Prep for display; adds gesture recognizer, pull current settings and fill data to be accurate
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//        self.view.setNeedsLayout()
        
        
//        let radius = self.view.frame.width / 20
//        let rect = CGRect(x: 0, y: 22, width: self.view.frame.width, height: self.view.frame.height - 44)
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
//        let maskView = CAShapeLayer()
//        maskView.path = path.cgPath
//        maskView.fillColor = UIColor.white.cgColor
//        self.view.layer.mask = maskView
        
        
        // Load the current grid count
        var gridCount = UserDefaults.standard.integer(forKey: constants.defaults.gridCount)
        if gridCount == 0{
            UserDefaults.standard.set(constants.defaultValues.gridCount, forKey: constants.defaults.gridCount)
            gridCount = constants.defaultValues.gridCount
        }
        gridsLabel.text = "\(gridCount)"
        gridStepper.value = Double(gridCount)
        
        // Load the current duration
        var timeInterval = UserDefaults.standard.double(forKey: constants.defaults.chordDuration)
        if timeInterval == 0{
            UserDefaults.standard.set(constants.defaultValues.chordDuration, forKey: constants.defaults.chordDuration)
            timeInterval = constants.defaultValues.chordDuration
        }
        durationStepper.value = timeInterval
        durationLabel.text = "\(timeInterval)"
        
        // Load which chord mode we're in
        let useAllChords = UserDefaults.standard.bool(forKey: constants.defaults.allChordsEnabled)
        chordSwitch.setOn(useAllChords, animated: false)
        
        // Set up the random count
        if UserDefaults.standard.bool(forKey: constants.defaults.randomCountInitalized){
            let rVal = UserDefaults.standard.integer(forKey: constants.defaults.randomCount)
            randomStepper.value = Double(rVal)
            randomLabel.text = "\(rVal)"
        }else{
            UserDefaults.standard.set(constants.defaultValues.randomCount, forKey: constants.defaults.randomCount)
            UserDefaults.standard.set(true, forKey: constants.defaults.randomCountInitalized)
            let rVal = constants.defaultValues.randomCount
            randomStepper.value = Double(rVal)
            randomLabel.text = "\(rVal)"
        }
        
        let swipDownGR = UISwipeGestureRecognizer(target: self, action: #selector(doneButton(_:)))
        swipDownGR.direction = .down
        self.view.addGestureRecognizer(swipDownGR)
    }
}
