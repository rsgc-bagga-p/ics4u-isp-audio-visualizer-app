//
//  Scene.swift
//  MicrophoneAnalysis
//
//  Created by Russell Gordon on 12/14/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import AudioKit
import SpriteKit

class Scene : SKScene {
    
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    var audioFile : AKAudioFile!
    var player : AKAudioPlayer!
    var sinOutput : AKOutputWaveformPlot!
    public var fileToAnalyze : String = ""
    
    class Particles {
        let particleType = SKTexture(imageNamed: "spark")
        let emmitter = SKEmitterNode()
        var hue : CGFloat = 0.0
    }
    
    var backButton = SKSpriteNode()
    
    let particles = Particles()
    
    // Label for amplitude
    let labelAmplitude = SKLabelNode(fontNamed: "Helvetica")
    let labelFrequency = SKLabelNode(fontNamed: "Helvetica")
    
    // Circle
    var shapeCircle = SKShapeNode()
    var centrePoint = CGPoint()
    
    // For tracking elapsed time
    var elapsedTime: Int = 0
    var startTime: Int?
    
    // For tracking frames
    var frameCount = 0
    
    func analyzer(intensity: CGFloat ) -> SKEmitterNode {
        
        particles.emmitter.zPosition = 2
        particles.emmitter.particleTexture = particles.particleType
        particles.emmitter.particleBirthRate = 4000 * intensity
        particles.emmitter.numParticlesToEmit = Int(intensity * 100)
        particles.emmitter.particleLifetime = 2.0
        particles.emmitter.emissionAngle = CGFloat(90.0)
        particles.emmitter.emissionAngleRange = CGFloat(360.0)
        particles.emmitter.particleSpeed = CGFloat(tracker.frequency)
        //.emmitter.particleSpeedRange = CGFloat(1000 * tracker.frequency)
        particles.emmitter.particleAlpha = 1.0
        particles.emmitter.particleAlphaRange = 0.25
        particles.emmitter.particleScale = 1.2
        particles.emmitter.particleScaleRange = 2.0
        particles.emmitter.particleScaleSpeed = -1.5
        if tracker.amplitude > 0.5 {
            
            
            particles.hue = abs(CGFloat(tracker.frequency).remainder(dividingBy: 360)/360)
            
            
        }
        particles.emmitter.particleColor = NSColor(hue: particles.hue, saturation: 0.8, brightness: 0.9, alpha: 0.2)
        particles.emmitter.particleColorBlendFactor = 1
        particles.emmitter.particleBlendMode = SKBlendMode.add
        return particles.emmitter
    }
    
    override func didMove(to view: SKView) {
        // Set the background color
        backgroundColor = SKColor.black
        
        
        // Show the amplitude
        labelAmplitude.text = "Amplitude is: "
        labelAmplitude.fontColor = SKColor.white
        labelAmplitude.fontSize = 24
        labelAmplitude.zPosition = 150
        labelAmplitude.position = CGPoint(x: size.width / 2, y: size.height / 5 * 1)
        addChild(labelAmplitude)

        // Show the frequency
        labelFrequency.text = "Frequency is: "
        labelFrequency.fontColor = SKColor.white
        labelFrequency.fontSize = 24
        labelFrequency.zPosition = 150
        labelFrequency.position = CGPoint(x: size.width / 2, y: size.height / 5 * 2)
        addChild(labelFrequency)
        
        // Try to get a reference to the audio file
        do {
            audioFile = try AKAudioFile(readFileName: fileToAnalyze, baseDir: .documents)
        } catch {
            print("Could not open audio file")
        }
        
        // Play the audio file
        if audioFile != nil {

            do {
                player = try AKAudioPlayer(file: audioFile)
                player.looping = true
            } catch {
                print("Could not play audio file")
            }
            
        }
        
        // Analyse the song being played
        if player != nil {
            tracker = AKFrequencyTracker(player)
            
            // Start AudioKit

            AudioKit.output = tracker
            AudioKit.start()
            player.play()
            
        }
        


        // Configure the circle in the middle
        centrePoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        shapeCircle = SKShapeNode(circleOfRadius: 10)
        shapeCircle.position = centrePoint
        addChild(shapeCircle)
        
        
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
        
        // Remove the circle
        shapeCircle.removeFromParent()

        // Only analyze if volume (amplitude) reaches a certain threshold
        if tracker.amplitude > 0.1 && player != nil {
            
            // Show the frequency
            labelFrequency.text = "Frequency is: " + String(format: "%0.1f", tracker.frequency)
            
            // Show the amplitude
            labelAmplitude.text = "Amplitude is: " + String(format: "%0.2f", tracker.amplitude)
            
            
           // self.backgroundColor = SKColor.black //change the background colour
//            // Set the colour of the background based on the frequency
//            // See for further details about how hue value works:
//            // http://russellgordon.ca/rsgc/2016-17/ics2o/HSB%20Colour%20Model%20-%20Summary%20-%20Swift.pdf
            
            //changes to the high beats of a song
            //if tracker.amplitude > 0.5 {
            //let hue = abs(CGFloat(tracker.frequency).remainder(dividingBy: 360)/360)
            //backgroundColor = NSColor(hue: hue, saturation: 0.8, brightness: 0.9, alpha: 0.2)
            
        //}
        
            particles.emmitter.zPosition = 2
            particles.emmitter.particleTexture = particles.particleType
            particles.emmitter.particleBirthRate = 80
            particles.emmitter.numParticlesToEmit = Int(200)
            particles.emmitter.particleLifetime = 2.0
            //particles.emmitter.emissionAngle = CGFloat(90.0)
            //particles.emmitter.emissionAngleRange = CGFloat(360.0)
            particles.emmitter.particleSpeed = CGFloat(200)
            //.emmitter.particleSpeedRange = CGFloat(1000 * tracker.frequency)
            particles.emmitter.particleAlpha = 1.0
            particles.emmitter.particleAlphaRange = 0.25
            particles.emmitter.particleScale = 1.2
            particles.emmitter.particleScaleRange = 2.0
            particles.emmitter.particleScaleSpeed = -1.5
            if tracker.amplitude > 0.5 {
                
                
                particles.hue = abs(CGFloat(tracker.frequency).remainder(dividingBy: 360)/360)
                
                
            }
            particles.emmitter.particleColor = SKColor.orange//NSColor(hue: particles.hue, saturation: 0.8, brightness: 0.9, alpha: 0.2)
            particles.emmitter.particleColorBlendFactor = 1
            particles.emmitter.particleBlendMode = SKBlendMode.add
            particles.emmitter.position = CGPoint(x: size.width / 2, y: size.height / 2)
            particles.emmitter.particlePositionRange = CGVector(dx: frame.maxX, dy: 0)
            addChild(particles.emmitter)
        // Resize the circle based on amplitude
        //shapeCircle = SKShapeNode(circleOfRadius: CGFloat(tracker.amplitude * 700))
        //shapeCircle.position = centrePoint
        //shapeCircle.zPosition = 0
        //addChild(shapeCircle)
            
        }
        
    }
    
}
