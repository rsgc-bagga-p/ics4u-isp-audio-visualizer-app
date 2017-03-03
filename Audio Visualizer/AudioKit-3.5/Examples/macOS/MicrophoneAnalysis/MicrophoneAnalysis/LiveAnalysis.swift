//
//  LiveAnalysis.swift
//  MicrophoneAnalysis
//
//  Created by Puneet Singh Bagga on 2017-03-01.
//  Copyright © 2017 AudioKit. All rights reserved.
//

import Cocoa
import AudioKit
import SpriteKit

class LiveAnalysis: SKScene {
    
    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    
    override func didMove(to view: SKView) {
        var tracker = AKFrequencyTracker.init(mic, hopSize: 200, peakCount: 2000)
        var silence = AKBooster(tracker, gain: 0)
        
    }
    
}
