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
    
    //backButton
    var backButton = SKSpriteNode()
    
    // Circle
    var shapeCircle = SKShapeNode()
    var centrePoint = CGPoint()
    
    // For tracking elapsed time
    var elapsedTime: Int = 0
    var startTime: Int?
    
    // For tracking frames
    var frameCount = 0
    
    override func didMove(to view: SKView) {
        
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)
        AudioKit.output = silence
        AudioKit.start()
        
        // Configure the circle in the middle
        centrePoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        shapeCircle = SKShapeNode(circleOfRadius: 10)
        shapeCircle.position = centrePoint
        addChild(shapeCircle)
        
        backButton = SKSpriteNode(imageNamed: "backButton")
        backButton.position = CGPoint(x: 50, y: 50)
        backButton.setScale(0.3)
        backButton.zPosition = 200
        self.addChild(backButton)
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
        
        // Remove the circle
        shapeCircle.removeFromParent()
        
        //changes to the high beats of a song
        
        if tracker.amplitude > 0.5 {
            
            
            let hue = abs(CGFloat(tracker.frequency).remainder(dividingBy: 360)/360)
            backgroundColor = NSColor(hue: hue, saturation: 0.8, brightness: 0.9, alpha: 0.2)
            
        }
        
        // Resize the circle based on amplitude
        shapeCircle = SKShapeNode(circleOfRadius: CGFloat(tracker.amplitude * 700))
        shapeCircle.position = centrePoint
        shapeCircle.zPosition = 0
        addChild(shapeCircle)
    }
    
    
    override func mouseDown(with event: NSEvent) {
        // Look for a click on the back button
        if backButton.frame.contains(event.locationInWindow) {
            print("back button pressed.")
            
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
