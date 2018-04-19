//
//  OnboardingViewController.swift
//  mk
//
//  Created by Grey Patterson on 2018-04-18.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    /// Disable rotation on this view
    override var shouldAutorotate: Bool{
        return false
    }
    /// The 'got it!' button
    @IBOutlet weak var gotItButton: UIButton!
    
    /// Handle the 'got it' button being pressed
    ///
    /// - Parameter sender: `gotItButton`
    @IBAction func gotItPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Set things up!
    override func viewDidLoad() {
        super.viewDidLoad()
        gotItButton.layer.cornerRadius = constants.defaultValues.buttonCornerRadius
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
    }
}
