//
//  PlayViewController.swift
//  Pitch Perfect
//
//  Created by Wassim Seifeddine on 3/1/16.
//  Copyright © 2016 Wassim Seifeddine. All rights reserved.
//

import UIKit
import AVFoundation


class PlayViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    
    @IBOutlet weak var stopButtonOutlet: UIButton!
    var receivedAudio : RecordedAudio!
    
    var audioPlayer  : AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    func playAudioPlayerWithDifferentRate(rate : Float){
        
        audioPlayer.rate = rate
        audioPlayer.play()
        
        
    }
    
    func stopAndResetAudioEngineAndPlayer(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAndResetAudioEngineAndPlayer()
        
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
        stopAndResetAudioEngineAndPlayer()
        
        
    }
    
    @IBAction func snailPlayAudio(sender: AnyObject) {
        stopAndResetAudioEngineAndPlayer()
        
        stopButtonOutlet.hidden = false
        
        
        playAudioPlayerWithDifferentRate(0.5)
    }
    
    
    
    
    @IBAction func rabbitPlayAudio(sender: AnyObject) {
        stopAndResetAudioEngineAndPlayer()
        
        
        stopButtonOutlet.hidden = false
        
        playAudioPlayerWithDifferentRate(2)
        
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
                self.audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.getFilePathURL())
            self.audioPlayer.enableRate = true
            audioFile = try! AVAudioFile(forReading: receivedAudio.getFilePathURL())
            
            audioPlayer.delegate = self
            
            
        }catch{
        }
    }
    
    
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        stopButtonOutlet.hidden = true
        
    }
    
    
    
    
    
}
