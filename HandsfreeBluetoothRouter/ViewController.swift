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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let myRoutePickerView = AVRoutePickerView()
        myRoutePickerView.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        myRoutePickerView.delegate = self
        self.view.addSubview(myRoutePickerView)
        
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [.allowBluetooth, .mixWithOthers, .allowAirPlay])
            
        } catch {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func play(_ sender: Any) {
        do {
        try audioSession.setActive(true)
        } catch {
            
        }

//        let currentRoute = audioSession.currentRoute
        var text = "Current Route: \(audioSession.currentRoute)\n\n"
        let inputs = audioSession.availableInputs
        inputs?.forEach({ portDesc in
            text.append("Port Desc: \(portDesc) \n\n")
        })
        
        let modes = audioSession.availableModes
        text.append("Current Mode: \(audioSession.mode)\n\n")
        text.append("Available Modes: \n")
        modes.forEach { mode in
            text.append("Mode: \(mode)\n")
        }
        
        
        textArea.text = text
        
        
        
        
        
    }
    
    @IBOutlet weak var textArea: UITextView!
    

}

extension ViewController: AVRoutePickerViewDelegate {
    
}
