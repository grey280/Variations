//
//  ViewController.swift
//  mk
//
//  Created by Grey Patterson on 2018-01-19.
//  Copyright © 2018 Grey Patterson. All rights reserved.
//

import UIKit
import AudioKit

/// The main ViewController for everything; honestly this is gonna be a Massive View Controller deal probably, but I'm okay with that
class ViewController: UIViewController {
    // MARK: Variables
    /// The list of grids that will be displayed on-screen
    var grids = [GridView]()
    
    /// The list of oscillators that's used to generate audio
    var oscillators = [AKPolyphonicNode]()
    
    /// The primary mixer node; outputs to AudioKit out, so it's the audio out for everything
    var mixerNode = AKMixer()
    
    /// A global instance of GridConverter for use everywhere
    let gc = GridConverter()
    
    // MARK: - Helper Functions
    
    // Test code
    /// Iterate the grids when the screen is tapped
    @objc func handleTap(){
        iterate()
    }
    
    /// Generate a random square grid with the given dimension
    ///
    /// - Parameter dimension: the size of the grid to generate
    /// - Returns: an instance of `Grid` with a randomly-generated beginning state
    private func randomGrid(_ dimension: Int) -> Grid{
        let tempGrid = Grid(x: dimension, y: dimension)!
        for _ in 0..<Int(1.5*dimension){
            tempGrid.cell(x: Int(arc4random_uniform(UInt32(dimension))), y: Int(arc4random_uniform(UInt32(dimension))), alive: true)
        }
        return tempGrid
    }
    
    /// Generates a random color
    ///
    /// - Returns: a randomized UIColor
    private func randomColor() -> UIColor{
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    /// Create a table from a given input
    ///
    /// - Parameter input: a double; assumes roughly in the range 0.0-1.0, but not required
    /// - Returns: an AKTable instance with a waveform chosen based on the input
    private func tableFrom(_ input: Double) -> AKTable{
        let choice = Int(input * 10) % 8
        switch choice {
        case 0:
            return AKTable(.positiveSawtooth)
        case 1:
            return AKTable(.triangle)
        case 2:
            return AKTable(.square)
        case 3:
            return AKTable(.sawtooth)
        case 4:
            return AKTable(.positiveSine)
        case 5:
            return AKTable(.positiveTriangle)
        case 6:
            return AKTable(.positiveSquare)
        default:
            return AKTable(.sine)
        }
    }
    
    // MARK: - Grid Interactions
    
    /// Iterate all grids at once, including randomization
    func iterate(){
        iterate(2)
    }
    
    /// Iterate all grids at once, including the given number of randomly flipped tiles
    ///
    /// - Parameter randoms: the number of tiles to flip (random grid, random tile, each time)
    func iterate(_ randoms: Int){
        for gridView in grids{
            gridView.grid.iterate{
                gridView.iterationComplete()
            }
        }
        
        for _ in 0..<randoms{
            let gridTweak = Int(arc4random_uniform(UInt32(grids.count)))
            let gridX = Int(arc4random_uniform(UInt32(grids[gridTweak].grid.width)))
            let gridY = Int(arc4random_uniform(UInt32(grids[gridTweak].grid.height)))
            grids[gridTweak].grid.toggleCell(x: gridX, y: gridY)
        }
    }
    
    /// Which chord should we be playing?
    ///
    /// - Returns: the chord we're currently playing
    func getChord() -> GridConverter.chord{
        // let freeMode = false // Later we'll need this as a setting so we can have chords other than I IV V I
        let gridParity = grids[0].grid.parity() // TODO: Error handling
        // in case this function is called before grids has been initialized properly
        let columnParity = grids[0].grid.columnParity()
        if gridParity && columnParity{
            return .I
        } else if gridParity{
            return .IV
        } else if columnParity{
            return .V
        }
        return .I
    }
    
    /// Determines the MIDI note velocity based on how far in the grid you are
    ///
    /// - Parameters:
    ///   - width: the width of the grid in question
    ///   - current: the current active column of the grid in question
    /// - Returns: the MIDI note velocity to use
    func velocity(width: Int, current: Int) -> MIDIVelocity{
        let perc = Double(current) / Double(width)
        let temp = (perc - 0.5) * 3
        var temp2 = (1/sqrt(2*Double.pi))
        let temp3 = -0.5 * temp * temp
        temp2 = temp2 * exp(temp3)
        return MIDIVelocity(temp2*150)
    }
    
    /// Counter for the additive synthesis system
    private var addSynthCount = 0
    
    /// Fire a 'tick' on all the grids at once, and switch the oscillators to playing the new notes
    func tick(){
        for i in 0..<grids.count{
            grids[i].grid.tick()
        }
        addSynthCount += 1
        if addSynthCount < grids.count{
            for i in 0..<addSynthCount{
                if !grids[i].grid.enabled{
                    grids[i].grid.enabled = true
                    grids[i].iterationComplete()
                }
            }
        }
        let currentChord = getChord()
        for i in 1..<grids.count{
            for j in 0..<128{ // Stop playing *all* notes, not just the ones that you *think* were already playing. Fixes the bug that cropped up from iterations happening between ticks.
                oscillators[i].stop(noteNumber: MIDINoteNumber(j))
            }
            let actives = grids[i].grid.column()
            let activeNotes = gc.convert(actives, chord: currentChord)
            for note in activeNotes{
                oscillators[i].play(noteNumber: MIDINoteNumber(note), velocity: velocity(width: grids[i].grid.width, current: grids[i].grid.activeColumn))
            }
        }
    }
    
    // MARK: - Configuration
    
    /// Wrapper for `buildGrids`
    @objc private func resetGrids(){
        buildGrids(8)
    }
    
    /// Build the given number of grids, including configuring the oscillators
    ///
    /// - Parameter number: number of grids to build
    private func buildGrids(_ number: Int){
        do{
            try AudioKit.stop()
        }catch{
            print("AudioKit failed to stop")
        }
        for i in 0..<grids.count{
            grids[i].removeFromSuperview()
        }
        for i in 0..<oscillators.count{ // TODO: Avoid potential memory leak
            // Verify that this is actually detaching all the nodes from the mixer like it's supposed to be, otherwise that could be both a heck of a memory leak *and* a nice mismash of sound
            oscillators[i].detach()
        }
        grids = [GridView]()
        for _ in 0..<number{
            let tempGrid = randomGrid(Int(arc4random_uniform(25))+1)
            let tempGridView = GridView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), grid: tempGrid)
            tempGridView.gridColor = randomColor()
            grids.append(tempGridView)
            
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            tempGridView.gridColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
            
            let oscillator = AKOscillatorBank(waveform: tableFrom(Double(hue)), attackDuration: Double(saturation)/5, releaseDuration: Double(brightness)/5)
            oscillators.append(oscillator)
            mixerNode.connect(input: oscillator)
            self.view.addSubview(tempGridView)
        }
        addSynthCount = 0
        grids[0].grid.enabled = true
        do{
            try AudioKit.start()
        }catch{
            fatalError("AudioKit failed to start")
        }
    }
    
    // MARK: - ViewController Globals
    
    /// Set up the view to run
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.resetGrids))
        swipeRecognizer.direction = .down
        self.view.addGestureRecognizer(swipeRecognizer)
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            self.tick()
        }
        
        AudioKit.output = mixerNode
        AKSettings.playbackWhileMuted = true // We don't want to force the user to flip the mute switch to hear anything
        
        let didRotate: (Notification) -> Void = { notification in
            for grid in self.grids{
                grid.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }
        }
        NotificationCenter.default.addObserver(forName: .UIDeviceOrientationDidChange, object: nil, queue: .main, using: didRotate)
        
        buildGrids(8)
    }
    
    /// Hide the status bar; it doesn't look super good with it displayed, after all.
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

