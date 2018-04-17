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
        /// Number of cells to randomly toggle per iteration
        static let randomCount = "randomCount"
        /// Whether or not `randomCount` has been initialized
        static let randomCountInitalized = "randomCountInitialized"
    }
    
    /// Constants to use for default values, so we don't have any magic numbers
    struct defaultValues{
        /// Default number of grids to have on-screen
        static let gridCount = 8
        /// Default duration to allow each chord to play for
        static let chordDuration = 3.0
        /// Default number of cells to randomly toggle per iteration
        static let randomCount = 2
    }
    
    /// Configuration states for the change thing
    struct configs{
        /// "Meditate" mode - a calm experience
        struct meditate{
            /// Number of grids to operate
            static let gridCount = 4
            /// Length of time ot let chords stay
            static let chordDuration = 5.0
            /// Whether or not all chords are in use
            static let allChordsEnabled = false
            /// Number of cells to randomly toggle per iteration
            static let randomCount = 0
        }
        struct original{
            /// Number of grids to operate
            static let gridCount = 8
            /// Length of time ot let chords stay
            static let chordDuration = 3.0
            /// Whether or not all chords are in use
            static let allChordsEnabled = false
            /// Number of cells to randomly toggle per iteration
            static let randomCount = 2
        }
        struct energy{
            /// Number of grids to operate
            static let gridCount = 6
            /// Length of time ot let chords stay
            static let chordDuration = 0.5
            /// Whether or not all chords are in use
            static let allChordsEnabled = true
            /// Number of cells to randomly toggle per iteration
            static let randomCount = 10
        }
    }
}
