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
    
    //scene to hold the file directory
    var file : String = ""
    //declare the play visualizer button
    var button = SKSpriteNode()
    //Welcome Title
    var welcomeTitle = SKLabelNode()
    //Microphone Label
    var microphoneLabel = SKLabelNode()
    //Microphone Button
    var microButton = SKSpriteNode()
    //Add Button 
    var addButton = SKSpriteNode()
    
    // This method runs once after the scene loads
    override func didMove(to view: SKView) {
     
        self.backgroundColor = SKColor.black //change the background colour
                
        //Preloaded Music Visualizer Button
        button = SKSpriteNode(imageNamed: "Play Button")
        button.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 100)
        button.setScale(0.1)
        button.zPosition = 200
        self.addChild(button)
        
        //Microphone Visualizer Button
        microButton = SKSpriteNode(imageNamed: "Play Button")
        microButton.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 200)
        microButton.setScale(0.1)
        microButton.zPosition = 200
        self.addChild(microButton)
        
        //Choose Music Button
        addButton = SKSpriteNode(imageNamed: "Image")
        addButton.position = CGPoint(x: self.size.width - 55, y: self.size.height - 60)
        addButton.setScale(0.5)
        addButton.zPosition = 200
        self.addChild(addButton)
        
        //Welcome Title for Menu
        welcomeTitle = SKLabelNode(fontNamed: "Futura Bold")
        welcomeTitle.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 300 )
        welcomeTitle.isHidden = false
        welcomeTitle.fontSize = 48
        welcomeTitle.zPosition = 250
        welcomeTitle.fontColor = SKColor.white
        welcomeTitle.text = "Welcome"
        self.addChild(welcomeTitle)
        
        // Label for the Microphone Button
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
            scene.fileToAnalyze = file
            
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
        
        //Lood for a click on the add button
        if addButton.frame.contains(event.locationInWindow) {
            print("Add Button Pressed")
            
            let dialog = NSOpenPanel();
            
            dialog.title                   = "Choose a .mp3 file";
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = false;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes        = ["mp3"];
            
            if (dialog.runModal() == NSModalResponseOK) {
                
                if let result = dialog.url { // Pathname of the file
                    print(result.path)
                    print(result.lastPathComponent)
                    print(result.pathComponents)
                    file = result.lastPathComponent
                }
            } else {
                // User clicked on "Cancel"
                return
            }

        }
        
    }
}
