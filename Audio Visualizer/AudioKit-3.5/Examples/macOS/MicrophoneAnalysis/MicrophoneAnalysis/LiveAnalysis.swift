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
    
    class Particles {
        let particleType = SKTexture(imageNamed: "spark")
        let emmitter = SKEmitterNode()
        var hue : CGFloat = 0.0
        var particlesToemmit : Int = 4000
    }
    
    let particles = Particles()
    
    //backButton
    var backButton = SKSpriteNode()
    
    // For tracking elapsed time
    var elapsedTime: Int = 0
    var startTime: Int?
    
    // For tracking frames
    var frameCount = 0
    
    override func didMove(to view: SKView) {
        // Set the background color
        backgroundColor = SKColor.black
        
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)
        AudioKit.output = silence
        AudioKit.start()
        
        
        backButton = SKSpriteNode(imageNamed: "backButton")
        backButton.position = CGPoint(x: 50, y: 50)
        backButton.setScale(0.3)
        backButton.zPosition = 200
        self.addChild(backButton)
        
        particles.emmitter.zPosition = 2
        particles.emmitter.particleTexture = particles.particleType
        particles.emmitter.particleBirthRate = 80
        particles.emmitter.numParticlesToEmit = particles.particlesToemmit
        particles.emmitter.particleLifetime = 2.0
        particles.emmitter.particleSpeed = CGFloat(200)
        particles.emmitter.particleAlpha = 1.0
        particles.emmitter.particleAlphaRange = 0.25
        particles.emmitter.particleScale = 1.2
        particles.emmitter.particleScaleRange = 2.0
        particles.emmitter.particleScaleSpeed = -1.5
        particles.emmitter.particleColor = SKColor.orange
        particles.emmitter.particleColorBlendFactor = 1
        particles.emmitter.particleBlendMode = SKBlendMode.add
        particles.emmitter.position = CGPoint(x: size.width / 2, y: size.height / 2)
        particles.emmitter.particlePositionRange = CGVector(dx: frame.maxX, dy: 0)
        addChild(particles.emmitter)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Check to see if visualization has been started yet
        if let startTime = startTime {
            // If started, how much time has elapsed?
            let time = Int(currentTime) - startTime
            if time != elapsedTime {
                elapsedTime = time
                print(elapsedTime)
            }
        } else {
            // If not started, set the start time
            startTime = Int(currentTime) - elapsedTime
        }
        
        // Increment frame count
        frameCount += 1
        
        if tracker.amplitude > 0.2 {
            particles.hue = abs(CGFloat(tracker.frequency * 100.0).remainder(dividingBy: 360)/360)
        }
        particles.emmitter.particleColor = NSColor(hue: particles.hue, saturation: 0.8, brightness: 0.9, alpha: 0.2)
        particles.emmitter.particleBirthRate = 80
        particles.emmitter.particleSpeed = CGFloat(tracker.amplitude * 1000)
        particles.particlesToemmit += 80
        particles.emmitter.numParticlesToEmit = particles.particlesToemmit
        particles.emmitter.emissionAngle = CGFloat(tracker.amplitude * 200)

    }
    
    
    override func mouseDown(with event: NSEvent) {
        // Look for a click on the back button
        if backButton.frame.contains(event.locationInWindow) {
            print("back button pressed.")
            
            //stop AudioKit
            AudioKit.stop()
            
            // Create the menu scene with the same dimensions as the current scene
            let menu = MenuScene(size: self.size)
            
            // Configure a transition object to specify the type of animation that handles the move between scenes
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 0.2)
            
            // Access the current view and present the new scene
            // NOTE: We know the current scene has a view object (since the game is running) so it is safe to force-unwrap the optional view property of the current scene
            self.view!.presentScene(menu, transition: reveal)
        }
    }
    
    
}
