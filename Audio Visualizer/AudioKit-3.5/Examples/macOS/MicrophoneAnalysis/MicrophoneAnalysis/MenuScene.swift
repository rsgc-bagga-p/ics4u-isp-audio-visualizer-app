//
//  MenuScene.swift
//  MicrophoneAnalysis
//
//  Created by Puneet Singh Bagga on 2017-02-27.
//  Copyright © 2017 AudioKit. All rights reserved.
//

import Cocoa
import SpriteKit

class MenuScene: SKScene {

    //declare the play visualizer button
    var button = SKSpriteNode()
    //Welcome Title
    var welcomeTitle = SKLabelNode()
    //Microphone Label
    var microphoneLabel = SKLabelNode()
    //Microphone Button
    var microButton = SKSpriteNode()
    
    // This method runs once after the scene loads
    override func didMove(to view: SKView) {
     
        self.backgroundColor = SKColor.black //change the background colour
        
        button = SKSpriteNode(imageNamed: "Play Button")
        button.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 100)
        button.setScale(0.1)
        button.zPosition = 200
        self.addChild(button)
        
        microButton = SKSpriteNode(imageNamed: "Play Button")
        microButton.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 200)
        microButton.setScale(0.1)
        microButton.zPosition = 200
        self.addChild(microButton)
        
        welcomeTitle = SKLabelNode(fontNamed: "Futura Bold")
        welcomeTitle.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 300 )
        welcomeTitle.isHidden = false
        welcomeTitle.fontSize = 48
        welcomeTitle.zPosition = 250
        welcomeTitle.fontColor = SKColor.white
        welcomeTitle.text = "Welcome"
        self.addChild(welcomeTitle)
        
        microphoneLabel = SKLabelNode(fontNamed: "Futura Bold")
        microphoneLabel.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 100 )
        microphoneLabel.isHidden = false
        microphoneLabel.fontSize = 30
        microphoneLabel.zPosition = 250
        microphoneLabel.fontColor = SKColor.white
        microphoneLabel.text = "Live Audio Analysis"
        self.addChild(microphoneLabel)
        
    }
    
    override func mouseDown(with event: NSEvent) {
        
        // Look for a click on the play button
        //if button.int
        if button.frame.contains(event.locationInWindow) {
            print("Play button pressed.")
            
            // Create the menu scene with the same dimensions as the current scene
            let scene = Scene(size: self.size)
            
            // Configure a transition object to specify the type of animation that handles the move between scenes
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 0.2)
            
            // Access the current view and present the new scene
            // NOTE: We know the current scene has a view object (since the game is running) so it is safe to force-unwrap the optional view property of the current scene
            self.view!.presentScene(scene, transition: reveal)
        }
        
       // Look for a click on the microphone button
        if microButton.frame.contains(event.locationInWindow) {
            print("Live button pressed.")
            
            // Create the menu scene with the same dimensions as the current scene
            let live = LiveAnalysis(size: self.size)
            
            // Configure a transition object to specify the type of animation that handles the move between scenes
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 0.2)
            
            // Access the current view and present the new scene
            // NOTE: We know the current scene has a view object (since the game is running) so it is safe to force-unwrap the optional view property of the current scene
            self.view!.presentScene(live, transition: reveal)
        }
        
    }
}
