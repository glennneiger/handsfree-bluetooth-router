//
//  ViewController.swift
//  HandsfreeBluetoothRouter
//
//  Created by Ryan Walker on 10/12/17.
//  Copyright © 2017 Ryan Walker. All rights reserved.
//
//https://stackoverflow.com/questions/15643516/list-available-output-audio-target-avaudiosession

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sharedAudioSession = AVAudioSession.sharedInstance()
        
        scrollView.backgroundColor = UIColor.clear
//        let volumeView = MPVolumeView(frame: scrollView.bounds)
        
//        self.scrollView.addSubview(volumeView)
        
        let audioSession = AVAudioSession()
        
        do {
//            try audioSession.setCategory(AVAudioSessionCategoryRecord)
//            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [AVAudioSessionCategoryOptions.allowBluetooth, .mixWithOthers])
            
            try sharedAudioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .mixWithOthers)
        } catch {
            print("error")
        }
        
        if let inputs = audioSession.availableInputs {
            var ports = ""
            for input in inputs {
                ports.append("Uid: \(input.uid)\n")
                ports.append("Port Name: \(input.portName)\n")
                ports.append("Port Type: \(input.portType)\n\n")
                if(input.portType == "BluetoothHFP") {
                    do {
                        try audioSession.setPreferredInput(input)
                        try audioSession.setActive(true)
//                        try audioSession.setActive(false)
                    } catch {
                        print("more of them")
                    }
                    break
                }
            }
            print(ports)
            label.text = ports
        }
        
        if let outputs = audioSession.outputDataSources {
            print("outputs")
            for out in outputs {
                print(out.dataSourceName)
                print(out.location)
                print(out.dataSourceID)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

