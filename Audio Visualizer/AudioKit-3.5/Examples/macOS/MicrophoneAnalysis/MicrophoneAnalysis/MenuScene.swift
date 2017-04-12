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
    
    //class for all of the menu objects
    class MenuObjects {
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
        //Prechosen Audio Playback label
        var playBackLabel = SKLabelNode()
    }
    
    var menuObjects = MenuObjects() //declare a variable of type menu
    
    
    // This method runs once after the scene loads
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black //change the background colour
                
        //Preloaded Music Visualizer Button
        menuObjects.button = SKSpriteNode(imageNamed: "Play Button") //choose the image of the button
        menuObjects.button.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 100) //where will this sprite be?
        menuObjects.button.setScale(0.1) //the size of the sprite compared to the original image size
        menuObjects.button.zPosition = 200 //where it is on the z axis
        self.addChild(menuObjects.button) //add this as a child to the parent scene class
        
        //Microphone Visualizer Button
        menuObjects.microButton = SKSpriteNode(imageNamed: "Play Button")
        menuObjects.microButton.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 200)
        menuObjects.microButton.setScale(0.1)
        menuObjects.microButton.zPosition = 200
        self.addChild(menuObjects.microButton)
        
        //Welcome Title for Menu
        menuObjects.welcomeTitle = SKLabelNode(fontNamed: "Futura Bold") //declaring what type of node and what font
        menuObjects.welcomeTitle.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 300 )
        menuObjects.welcomeTitle.isHidden = false //is it hidden from the user?
        menuObjects.welcomeTitle.fontSize = 48 //size of the font
        menuObjects.welcomeTitle.zPosition = 250
        menuObjects.welcomeTitle.fontColor = SKColor.white //what colour the writing is
        menuObjects.welcomeTitle.text = "Audio Analyzer" //what should it say
        self.addChild(menuObjects.welcomeTitle)
        
        // Label for the Microphone Button
        menuObjects.microphoneLabel = SKLabelNode(fontNamed: "Futura Bold")
        menuObjects.microphoneLabel.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 100 )
        menuObjects.microphoneLabel.isHidden = false
        menuObjects.microphoneLabel.fontSize = 30
        menuObjects.microphoneLabel.zPosition = 250
        menuObjects.microphoneLabel.fontColor = SKColor.white
        menuObjects.microphoneLabel.text = "Live Audio Analysis"
        self.addChild(menuObjects.microphoneLabel)
        
        // Label for Chosen Music Label
        menuObjects.playBackLabel = SKLabelNode(fontNamed: "Futura Bold")
        menuObjects.playBackLabel.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 200)
        menuObjects.playBackLabel.isHidden = false
        menuObjects.playBackLabel.fontSize = 30
        menuObjects.playBackLabel.zPosition = 250
        menuObjects.playBackLabel.fontColor = SKColor.white
        menuObjects.playBackLabel.text = "Audio Analysis From File"
        self.addChild(menuObjects.playBackLabel)

        
    }
    
    override func mouseDown(with event: NSEvent) {
        
        // Look for a click on the play button
        //if button.int
        if menuObjects.button.frame.contains(event.locationInWindow) {
            
            let dialog = NSOpenPanel(); //opens finder search
            dialog.title                   = "Choose a .mp3 file";
            //allows for navigation
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = false;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes        = ["mp3"]; // the file type alloed
            
            if (dialog.runModal() == NSModalResponseOK) {
                
                if let result = dialog.url { // Pathname of the file
                    print(result.path)
                    print(result.lastPathComponent)
                    print(result.pathComponents)
                    menuObjects.file = result.lastPathComponent //load the file name into the file variable
                }
            } else {
                // User clicked on "Cancel"
                return
            }
            if menuObjects.file != "" { //if the file has something then...
            print("Play button pressed.")
            // Create the playBack visualizer scene with the same dimensions as the current scene
            let scene = Scene(size: self.size)
            scene.fileToAnalyze = menuObjects.file //the file name is saved into the other scene
            
            // Configure a transition object to specify the type of animation that handles the move between scenes
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 0.2)
            
            // Access the current view and present the new scene
            // NOTE: We know the current scene has a view object (since the game is running) so it is safe to force-unwrap the optional view property of the current scene
            self.view!.presentScene(scene, transition: reveal)
            }
        }
        
       // Look for a click on the microphone button
        if menuObjects.microButton.frame.contains(event.locationInWindow) {
            print("Live button pressed.")
            
            // Create the live analysis scene with the same dimensions as the current scene
            let live = LiveAnalysis(size: self.size)
            
            // Configure a transition object to specify the type of animation that handles the move between scenes
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 0.2)
            
            // Access the current view and present the new scene
            self.view!.presentScene(live, transition: reveal)
        }
        
    }
}
