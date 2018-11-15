//
//  ViewController.swift
//  HandsfreeBluetoothRouter
//
//  Created by Ryan Walker on 10/12/17.
//  Copyright © 2017 Ryan Walker. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    var audioSession: AVAudioSession!
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        let myRoutePickerView = AVRoutePickerView()
        myRoutePickerView.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        myRoutePickerView.delegate = self
        self.view.addSubview(myRoutePickerView)
        
        audioSession = AVAudioSession.sharedInstance()
        
        do {



            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
                                         mode: AVAudioSessionModeSpokenAudio,
                                         options: [.allowBluetooth, .mixWithOthers, .allowBluetoothA2DP])
            do {
                try audioSession.setActive(true)
            } catch {
                print("oh geeze")
            }

            
        } catch {
            
        }
        
    }

    @IBAction func play(_ sender: Any) {
        
        let url = Bundle.main.url(forResource: "silence", withExtension: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
        
//        let currentRoute = audioSession.currentRoute
//        var text = "Current Route: \(audioSession.currentRoute)\n\n"
//        let inputs = audioSession.availableInputs
//        inputs?.forEach({ portDesc in
//            text.append("Port Desc: \(portDesc) \n\n")
//        })
//
//        let modes = audioSession.availableModes
//        text.append("Current Mode: \(audioSession.mode)\n\n")
//        text.append("Available Modes: \n")
//        modes.forEach { mode in
//            text.append("Mode: \(mode)\n")
//        }
//
//
//        textArea.text = text
        
        
        
        
        
    }
    
    @IBOutlet weak var textArea: UITextView!
    

}

extension ViewController: AVRoutePickerViewDelegate {
    
}
