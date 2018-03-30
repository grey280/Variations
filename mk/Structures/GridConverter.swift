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
    /// Which chord are we looking at?
    ///
    /// - I: Tonic
    /// - ii: Supertonic
    /// - iii: Mediant
    /// - IV: Subdominant
    /// - V: Dominant
    /// - vi: Submediant
    /// - viio: Leading tone
    public enum chord{
        case I
        case ii
        case iii
        case IV
        case V
        case vi
        case viio
    }
    // Eb major: Eb, F, G, Ab, Bb, C, D
    /// The base notes of the scale; to get them in higher octaves, add multiples of 12
    private let baseNotes = [3, 5, 7, 8, 10, 12, 14]
    
    /// Gets the base numbers for a given chord
    ///
    /// - Parameter start: the chord to start with
    /// - Returns: the three chord tones to use as base numbers for other math
    private func chordBases(_ start: chord) -> [Int]{
        switch start {
        case .I:
            return [baseNotes[0], baseNotes[2], baseNotes[4]]
        case .ii:
            return [baseNotes[1], baseNotes[3], baseNotes[5]]
        case .iii:
            return [baseNotes[2], baseNotes[4], baseNotes[6]]
        case .IV:
            return [baseNotes[3], baseNotes[5], baseNotes[0]]
        case .V:
            return [baseNotes[4], baseNotes[6], baseNotes[1]]
        case .vi:
            return [baseNotes[5], baseNotes[0], baseNotes[2]]
        case .viio:
            return [baseNotes[6], baseNotes[1], baseNotes[3]]
        }
    }
    
    /// Gets the base displacement to use
    ///
    /// - Parameters:
    ///   - inputSize: the size of the input boolean array
    ///   - chordLimited: true if you're limiting to only chord tones, false if in 'free' mode
    /// - Returns: the number of octaves to displace by
    private func baseDisplacement(_ inputSize: Int, chordLimited: Bool = true) -> Int{
        if chordLimited{
            if inputSize > 20{
                return 1
            }
            if inputSize > 14{
                return 2
            }
            if inputSize > 8{
                return 3
            }
        }else{
            if inputSize > 48{
                return 1
            }
            if inputSize > 34{
                return 2
            }
            if inputSize > 20{
                return 3
            }
        }
        return 4
    }
    
    /// Convert a grid column into a collection of MIDI numbers, utilizing only chord tones from the given chord
    ///
    /// - Parameters:
    ///   - input: a grid column output, or any other boolean array
    ///   - chord: the chord to stay within
    /// - Returns: an array of MIDI note numbers
    func convert(_ input: [Bool], chord: chord) -> [Int]{
        var output = [Int]()
        let bases = chordBases(chord)
        let displace = baseDisplacement(input.count)
        for i in 0..<input.count{
            if input[i]{
                let theBase = bases[i%3]
                let localDisplace: Int = (i/3) + displace
                let res = theBase + localDisplace * 12
                output.append(res)
            }
        }
        return output
    }
    
    /// Convert a grid column into a collection of MIDI numbers, utilizing only tones in the key
    ///
    /// - Parameter input: a grid column output, or any other boolean array
    /// - Returns: an array of MIDI note numbers
    func convert(_ input: [Bool]) -> [Int]{
        var output = [Int]()
        let displace = baseDisplacement(input.count, chordLimited: false)
        for i in 0..<input.count{
            if input[i]{
                let theBase = baseNotes[i%7]
                let localDisplace: Int = (i/7) + displace
                let res = theBase + localDisplace * 12
                output.append(res)
            }
        }
        return output
    }
}
