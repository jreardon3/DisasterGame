//
//  SceneViewController.swift
//  DisasterGame
//
//  Created by Sydney Altobell on 3/4/18.
//  Copyright © 2018 Sydney Altobell. All rights reserved.
//

import UIKit
import SpriteKit

class SceneViewController: UIViewController {

    @IBOutlet  var sceneView: SKView!
    
    /*override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }*/
    override func viewWillLayoutSubviews() {
        
        // Configure the view.
        
        
        
        sceneView.showsFPS = true
        
        sceneView.showsNodeCount = true
        
        
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        
        sceneView.ignoresSiblingOrder = true
        
        
        
        let scene = GameScene(size: sceneView.frame.size)
    
        
        
        /* Set the scale mode to scale to fit the window */
        
        scene.scaleMode = .aspectFill
        
        
        
        sceneView.presentScene(scene)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
