//
//  CXVideo.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 28/05/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import AVKit
import AVFoundation

/// Useful class to handle Video related tasks
public class CXVideo {
    
    ///---
    /// Custom class to automate some functionality for AVPlayerViewController
    fileprivate class CXPlayerViewController: AVPlayerViewController{
        var playOnViewDidLoad = false
        
        fileprivate override func viewDidLoad() {
            super.viewDidLoad()
            
            if(playOnViewDidLoad){player?.play()}
        }
    }
    
    ///---
    /// AVPlayerLayer subclass to enables full screen size for lanscape orientation
    public class CXPlayerLayer: AVPlayerLayer{
        var myFrame = CGRect.zero
        
        override init(layer: Any) {
            super.init(layer: layer)
        }
        
        public init(frame: CGRect, videoURL:URL){
            self.myFrame = frame
            super.init()
            self.frame = myFrame
            self.player = AVPlayer(url: videoURL)
            
            //set observer to catch device orientation changes
            NotificationCenter.default.addObserver(self,
                                                             selector: #selector(CXPlayerLayer.orientationChanged),
                                                             name: NSNotification.Name.UIDeviceOrientationDidChange,
                                                             object: UIDevice.current)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        /// Plays the video if its possible
        public func play(){
            self.player?.play()
        }
        
        /// Sets the layer to full screen
        public func setFullScreen(){
            self.frame = CGRect(x: 0,
                                    y: 0,
                                    width: UIScreen.main.bounds.size.width,
                                    height: UIScreen.main.bounds.size.height)
            self.layoutIfNeeded()
        }
        
        public func orientationChanged(){
            let orientation = UIDevice.current.orientation
            
            //Restore the layer's original size
            if(orientation == UIDeviceOrientation.portrait && myFrame != frame) {
                frame = myFrame
                self.layoutIfNeeded()
            }else if(orientation == UIDeviceOrientation.landscapeLeft ||
                    orientation == UIDeviceOrientation.landscapeRight){
                self.setFullScreen()
            }
        }
    }
    
    ///---
    /// Instantiates a new UIViewController for play video
    ///
    /// - parameters:
    ///     - videoURL: The video Url
    ///     - showsPlayBackControls: Indicates if the view controller shows the play back controls
    public static func createVideoViewController(_ videoURL: URL, showsPlayBackControls: Bool, autoPlay: Bool) -> AVPlayerViewController{
        let player = AVPlayer(url: videoURL)
        let playerViewController = CXPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = showsPlayBackControls
        playerViewController.playOnViewDidLoad = autoPlay
        
        return playerViewController
    }
    
    ///---
    /// Instantiates a new CXPlayerLayer for play video
    ///
    /// - parameters:
    ///     - videoURL: The video Url
    ///     - frame: The layer frame
    public static func createVideoLayer(_ videoURL: URL, frame: CGRect) -> CXPlayerLayer {
        let playerLayer = CXPlayerLayer(frame: frame, videoURL: videoURL)
        
        return playerLayer
    }
    
    
}
