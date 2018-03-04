//
//  GameViewController.swift
//  DisasterGame
//
//  Created by Sydney Altobell on 3/3/18.
//  Copyright © 2018 Sydney Altobell. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
   
    
    override var shouldAutorotate: Bool {
       return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    @IBOutlet weak var hurricaneButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet var Tap_Main_Screen: UITapGestureRecognizer!
    
    
   
        
    
}
