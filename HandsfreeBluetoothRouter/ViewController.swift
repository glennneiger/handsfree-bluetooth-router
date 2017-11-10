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
    
    @IBOutlet weak var connectingLabel: UILabel!
    var audioSession = AVAudioSession()
    
    @IBAction func refresh(_ sender: Any) {
        loadRouteInfo()
    }
    @IBAction func disconnect(_ sender: Any) {
        do {
        try audioSession.setActive(false)
        } catch {}
        connectingLabel.text = "Disconnected"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadRouteInfo() {
        connectingLabel.text = "No Hands Free Device"
        audioSession = AVAudioSession()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [AVAudioSessionCategoryOptions.allowBluetooth, .mixWithOthers])
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
                        connectingLabel.text = "Connected"
                        try audioSession.setPreferredInput(input)
                        try audioSession.setActive(true)
                    } catch {
                        print("more of them")
                    }
                    break
                }
            }
            print(ports)
            label.text = ports
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
}

