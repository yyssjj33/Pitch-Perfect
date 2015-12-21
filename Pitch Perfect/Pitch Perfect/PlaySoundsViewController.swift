//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ji Yang on 12/19/15.
//  Copyright © 2015 Ji Yang. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            let filePathURL = NSURL.fileURLWithPath(filePath)
//            audioPlayer = try!AVAudioPlayer(contentsOfURL: filePathURL)
//            audioPlayer.enableRate = true
//        }else{
//            print("the filePath is empty")
//        }
        
        audioPlayer = try!AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func playNormal(sender: UIButton) {
        audioPlayer.rate = 1.0
        play()
    }
    
    @IBAction func playSlow(sender: UIButton) {

        audioPlayer.rate = 0.5
        play()

    }
    
    @IBAction func playFast(sender: UIButton) {
  
        audioPlayer.rate = 2.0
        play()

    }

    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func play(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitch = AVAudioUnitTimePitch()
        changePitch.pitch = pitch
        audioEngine.attachNode(changePitch)
        
        audioEngine.connect(audioPlayerNode, to: changePitch, format: nil)
        audioEngine.connect(changePitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    

    


}
