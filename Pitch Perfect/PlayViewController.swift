//
//  PlayViewController.swift
//  Pitch Perfect
//
//  Created by Wassim Seifeddine on 3/1/16.
//  Copyright © 2016 Wassim Seifeddine. All rights reserved.
//

import UIKit
import AVFoundation


class PlayViewController: UIViewController {
    
    
    
    @IBOutlet weak var stopButtonOutlet: UIButton!
    var receivedAudio : RecordedAudio!
    
    var audioPlayer  : AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0

    }
    
    @IBAction func snailPlayAudio(sender: AnyObject) {
        
        stopButtonOutlet.hidden = false
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    
    
    
    @IBAction func rabbitPlayAudio(sender: AnyObject) {
        stopButtonOutlet.hidden = false

        audioPlayer.stop()
        audioPlayer.currentTime = 0
        
        audioPlayer.rate = 2.0
        audioPlayer.play()
        
    }
    
    
    
    @IBAction func chipMunkPlayAudio(sender: AnyObject) {
        stopButtonOutlet.hidden = false

        playAudioWithVariablePitch(1000)
        
    }
    
    
    @IBAction func darthVaderPlayAudio(sender: AnyObject) {
        stopButtonOutlet.hidden = false

        playAudioWithVariablePitch(-1000)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButtonOutlet.hidden = true
        audioEngine = AVAudioEngine()
        
        do {
            try
                self.audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
            self.audioPlayer.enableRate = true
            audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
            
            
        }catch{}
        
        
        
        
        
    }
    
    
    
    
    
}
