//
//  ViewController.swift
//  Back To Bach App
//
//  Created by Андрей Понамарчук on 30.08.2018.
//  Copyright © 2018 Андрей Понамарчук. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "bach-bwv140-bisotti", ofType: "mp3")
    var timer = Timer()
    
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var positionSlider: UISlider!
    
    @IBAction func play(_ sender: UIBarButtonItem) {
        player.prepareToPlay()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        player.play()
    }
    @IBAction func pause(_ sender: UIBarButtonItem) {
        player.pause()
    }
    @IBAction func stop(_ sender: UIBarButtonItem) {
        player.stop()
        timer.invalidate()
        positionSlider.value = 0.0
        player.currentTime = 0.0
    }
    @IBAction func volumeSliderMoved(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    @IBAction func positionSliderMoved(_ sender: UISlider) {
        player.currentTime = Double(positionSlider.value)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        } catch {
            // Process any errors
        }
        positionSlider.maximumValue = Float(player.duration)
        positionSlider.value = 0.0
    }
    
    @objc func updateTimer () {
        positionSlider.value = Float(player.currentTime)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

