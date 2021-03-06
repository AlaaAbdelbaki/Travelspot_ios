//
//  ViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/18/20.
//

import UIKit
import AVFoundation
import GoogleSignIn

class ViewController: UIViewController {

    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var videoLayer: UIView!
    @IBAction func signinEmailBtn(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "loginWithEmailSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
          // Automatically sign in the user.
          GIDSignIn.sharedInstance()?.restorePreviousSignIn()
         //Do any additional setup after loading the view
        playVideo()
        
    }

    func playVideo(){
        guard let path = Bundle.main.path(forResource: "video" , ofType: "mp4")else{
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoLayer.layer.addSublayer(playerLayer)
        playerLayer.zPosition = -1
        player.play()
    }
    
}

