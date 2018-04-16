//
//  Constants.swift
//  mk
//
//  Created by Grey Patterson on 2018-04-16.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import Foundation

/// Constants for use throughout the app
struct constants{
    /// Constants for use with UserDefaults
    struct defaults{
        /// Whether or not the user has opted to use all chords (true) or only the I IV V I set (false)
        static let allChordsEnabled = "allChordsEnabled"
        /// The amount of time to allow each chord to play for, in seconds
        static let chordDuration = "chordDuration"
        /// The number of grids to display on-screen
        static let gridCount = "gridCount"
    }
    
    /// Constants to use for default values, so we don't have any magic numbers
    struct defaultValues{
        /// Default number of grids to have on-screen
        static let gridCount = 8
        /// Default duration to allow each chord to play for
        static let chordDuration = 3.0
    }
}
