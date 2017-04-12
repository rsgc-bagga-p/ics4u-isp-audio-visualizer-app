//
//  Scene.swift
//  MicrophoneAnalysis
//
//  Created by Russell Gordon on 12/14/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

//Load APIs
import AudioKit
import SpriteKit

class Scene : SKScene { //Scene class declared
    
    public var fileToAnalyze : String = ""
    
    class Particles {
        let particleType = SKTexture(imageNamed: "spark")
        let emmitter = SKEmitterNode()
        var hue : CGFloat = 0.0
        var particlesToemmit : Int = 4000
    }
    
    class Analysis {
        var tracker: AKFrequencyTracker! //tracks the audio frequency and amplitudes
        //initializes the audio file picker and player
        var audioFile : AKAudioFile!
        var player : AKAudioPlayer!
        var sinOutput : AKOutputWaveformPlot!
        var backButton = SKSpriteNode() //for the button to go back to the menu
    }
    
    let analysis = Analysis() //for the analysis
    
    let particles = Particles()
    
    // For tracking elapsed time
    var elapsedTime: Int = 0
    var startTime: Int?
    
    // For tracking frames
    var frameCount = 0
    
    override func didMove(to view: SKView) {
        
        // Set the background color
        backgroundColor = SKColor.black
        
        //backButton for the menu
        analysis.backButton = SKSpriteNode(imageNamed: "backButton")
        analysis.backButton.position = CGPoint(x: 50, y: 50)
        analysis.backButton.setScale(0.3)
        analysis.backButton.zPosition = 200
        self.addChild(analysis.backButton)
        
        // Try to get a reference to the audio file
        do {
            analysis.audioFile = try AKAudioFile(readFileName: fileToAnalyze, baseDir: .documents)
        } catch {
            print("Could not open audio file")
        }
        
        // Play the audio file
        if analysis.audioFile != nil {

            do {
                analysis.player = try AKAudioPlayer(file: analysis.audioFile)
                analysis.player.looping = true
            } catch {
                print("Could not play audio file")
            }
            
        }
        
        // Analyse the song being played
        if analysis.player != nil {
            analysis.tracker = AKFrequencyTracker(analysis.player)
            
            // Start AudioKit
            AudioKit.output = analysis.tracker
            AudioKit.start()
            analysis.player.play()
            
        }
        
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

    // This method runs approximately 30-60 times per second
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
        
        if analysis.tracker.amplitude > 0.5 {
            particles.hue = abs(CGFloat(analysis.tracker.frequency * 100.0).remainder(dividingBy: 360)/360)
        }
        particles.emmitter.particleColor = NSColor(hue: particles.hue, saturation: 0.8, brightness: 2, alpha: 0.2) //change the colour of the particle
        particles.emmitter.particleBirthRate = 300 //particles to emmitt initialy
        particles.emmitter.particleSpeed = CGFloat(analysis.tracker.amplitude * 500) //speed of the particle is set to the amplitude of the song
        particles.particlesToemmit += 80 //increase the particles to emmit
        particles.emmitter.numParticlesToEmit = particles.particlesToemmit //
        particles.emmitter.emissionAngle = CGFloat(analysis.tracker.amplitude * 200) //change the emmitter angle depending on the amplitude
        
    }
    
    override func mouseDown(with event: NSEvent) {
        // Look for a click on the back button
        if analysis.backButton.frame.contains(event.locationInWindow) {
            print("back button pressed.")
            
            //pause the music
            analysis.player.pause()
            
            //stop AudioKit
            AudioKit.stop()
            
            // Create the live analysis scene with the same dimensions as the current scene
            let menu = MenuScene(size: self.size)
            
            // Configure a transition object to specify the type of animation that handles the move between scenes
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 0.2)
            
            // Access the current view and present the new scene
            // NOTE: We know the current scene has a view object (since the game is running) so it is safe to force-unwrap the optional view property of the current scene
            self.view!.presentScene(menu, transition: reveal)
        }
    }
    
}
