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
    
    class Particles { //holds the particle variables
        let particleType = SKTexture(imageNamed: "spark") //the type of particle (what texture is used)
        let emmitter = SKEmitterNode() //emmitts the particles
        var hue : CGFloat = 0.0 //color of the particles
        var particlesToemmit : Int = 4000 //the number of particles to emmitt
    }
    
    class Analysis {
        
        var mic: AKMicrophone!  //intializes the microphone for input
        var tracker: AKFrequencyTracker! //track the frequency of the song
        var silence: AKBooster! //stereo booster
        var backButton = SKSpriteNode() //backbutton to go back to menu
        // For tracking elapsed time
        var elapsedTime: Int = 0
        var startTime: Int?
        // For tracking frames
        var frameCount = 0
    }
    
    let particles = Particles()
    let analysis = Analysis()
    
    override func didMove(to view: SKView) {
        // Set the background color
        backgroundColor = SKColor.black
        
        AKSettings.audioInputEnabled = true //is input enabled?
        analysis.mic = AKMicrophone() //set up the microphone
        analysis.tracker = AKFrequencyTracker.init(analysis.mic) //set up to track the input from the mic
        analysis.silence = AKBooster(analysis.tracker, gain: 0) //boost the mic values
        AudioKit.output = analysis.silence //output those values
        AudioKit.start() //start AudioKit
        
        
        //the button to go back to the meny
        analysis.backButton = SKSpriteNode(imageNamed: "backButton")
        analysis.backButton.position = CGPoint(x: 50, y: 50)
        analysis.backButton.setScale(0.3)
        analysis.backButton.zPosition = 200
        self.addChild(analysis.backButton)
        
        
        //set up the particle system
        particles.emmitter.zPosition = 2 //the depth of the particle
        particles.emmitter.particleTexture = particles.particleType //set the particle texture
        //particles.emmitter.particleBirthRate = 80 //particles to emmitt initialy
        //particles.emmitter.numParticlesToEmit = particles.particlesToemmit //number of particles to emmit
        particles.emmitter.particleLifetime = 1.0 //the length of the lifetime of the particle
        particles.emmitter.particleSpeed = CGFloat(200) //the speed of the particle
        particles.emmitter.particleAlpha = 1.0 //set the component of colour that blends colour and texture
        particles.emmitter.particleAlphaRange = 0.25 //set the range for changing values
        particles.emmitter.particleScale = 1.2 //the size of the particle
        particles.emmitter.particleScaleRange = 2.0 //average range of particles
        particles.emmitter.particleScaleSpeed = -1.5 //changing speed
        //particles.emmitter.particleColor = SKColor.orange //the initial colour of the particle
        particles.emmitter.particleColorBlendFactor = 1 //the colour blending with the texture
        particles.emmitter.particleBlendMode = SKBlendMode.add //blend the colour an texture
        particles.emmitter.position = CGPoint(x: size.width / 2, y: size.height / 2) //emmitter position
        particles.emmitter.particlePositionRange = CGVector(dx: frame.maxX, dy: 0) //where to emmitt range on the x axis
        addChild(particles.emmitter) //add as child
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Check to see if visualization has been started yet
        if let startTime = analysis.startTime {
            // If started, how much time has elapsed?
            let time = Int(currentTime) - startTime
            if time != analysis.elapsedTime {
                analysis.elapsedTime = time
                print(analysis.elapsedTime)
            }
        } else {
            // If not started, set the start time
            analysis.startTime = Int(currentTime) - analysis.elapsedTime
        }
        
        // Increment frame count
        analysis.frameCount += 1
        
        //change the colour of the particles based on the amplitude and frequency
        if analysis.tracker.amplitude > 0.2 {
            particles.hue = abs(CGFloat(analysis.tracker.frequency * 100.0).remainder(dividingBy: 360)/360)
        }
        particles.emmitter.particleColor = NSColor(hue: particles.hue, saturation: 0.8, brightness: 2, alpha: 0.2) //change the colour of the particle
        particles.emmitter.particleBirthRate = 300 //particles to emmitt initialy
        particles.emmitter.particleSpeed = CGFloat(analysis.tracker.amplitude * 1000) //speed of the particle is set to the amplitude of the song
        particles.particlesToemmit += 80 //increase the particles to emmit
        particles.emmitter.numParticlesToEmit = particles.particlesToemmit //
        particles.emmitter.emissionAngle = CGFloat(analysis.tracker.amplitude * 200) //change the emmitter angle depending on the amplitude

    }
    
    
    override func mouseDown(with event: NSEvent) {
        // Look for a click on the back button
        if analysis.backButton.frame.contains(event.locationInWindow) {
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
