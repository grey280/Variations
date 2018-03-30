//
//  GridConverter.swift
//  mk
//
//  Created by Grey Patterson on 2018-03-30.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import Foundation

/// Handles the conversions between the various data types we need
class GridConverter{
    /// The chords in a major key
    ///
    /// - I: Tonic
    /// - ii: Supertonic
    /// - iii: Mediant
    /// - IV: Subdominant
    /// - V: Dominant
    /// - vi: Submediant
    /// - viio: Leading tone
    enum majorKey{
        case I
        case ii
        case iii
        case IV
        case V
        case vi
        case viio
    }
    /// The chords in a minor key
    ///
    /// - i: Tonic
    /// - iio: Supertonic
    /// - III: Mediant
    /// - iv: Subdominant
    /// - v: Dominant (minor)
    /// - V: Dominant
    /// - VI: Submediant
    /// - VII: Subtonic
    /// - viio: Leading tone
    enum minorKey{
        case i
        case iio
        case III
        case iv
        case v
        case V
        case VI
        case VII
        case viio
    }
    /// Major or minor key?
    ///
    /// - major: A major key
    /// - minor: A minor key
    enum key{
        case major
        case minor
    }
    
    /// The specific type of chord that's active
    ///
    /// - major: A chord in a major key
    /// - minor: A chord in a minor key
    enum chord{
        case major(majorKey)
        case minor(minorKey)
    }
    
    /// Whether or not the output is 'free'. True means output is limited only to tones in the key; false limits the output to tones in the current chord.
    var free = false
}
