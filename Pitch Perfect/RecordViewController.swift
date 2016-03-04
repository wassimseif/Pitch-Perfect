//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Wassim Seifeddine on 2/29/16.
//  Copyright © 2016 Wassim Seifeddine. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recordedAudio : RecordedAudio!
    var audioRecorder:AVAudioRecorder!
    var paused : Bool = false
    
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    
    @IBOutlet weak var recordingLabelOutlet: UILabel!
    
    @IBAction func recordButtonPressed(sender: AnyObject) {
        
        recordingLabelOutlet.text = "Recording!"
        
        stopButtonOutlet.hidden = false
        pauseButtonOutlet.hidden = false
        audioRecorder.record()
        
        
    }
    
    
    @IBOutlet weak var stopButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        
        
        audioRecorder.delegate = self
        
        stopButtonOutlet.hidden = true
        pauseButtonOutlet.hidden = true
        
        recordingLabelOutlet.text = "Tap to Record!"
        
        
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        
        recordingLabelOutlet.text = "Tap to Record"
        stopButtonOutlet.hidden = true
        pauseButtonOutlet.hidden = true 
        audioRecorder.stop()
        let audioSesson = AVAudioSession.sharedInstance()
        
        do {
            try  audioSesson.setActive(false)
        }catch{
            
        }
        
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if ( !flag ){
            print("error in recording")
            return
        }
        print("Audio Recorded Sucessfully")
        recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathIURL: recorder.url)
        
        
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    }
    
    func setLabelText(){
        if paused {
            recordingLabelOutlet.text = "Paused"
        }else{
            recordingLabelOutlet.text = "Recording"
        }
    }
    
    @IBAction func pauseButtonPressed(sender: AnyObject) {
        
        // To be sure that a button invoked this action
        if let buttonPressed = sender as? UIButton {
            
            if !paused {
                audioRecorder.pause()
                pauseButtonOutlet.setImage(UIImage(named: "resume_160_blue"), forState: UIControlState.Normal)
                paused = !paused
                setLabelText()
                return
            }
            
            audioRecorder.record()
            pauseButtonOutlet.setImage(UIImage(named: "pause_160_blue"), forState: UIControlState.Normal)
            paused = !paused
            setLabelText()
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playVC: PlayViewController = segue.destinationViewController as! PlayViewController
            
            let data = sender as! RecordedAudio
            playVC.receivedAudio = data
            
        }
    }
    
}

