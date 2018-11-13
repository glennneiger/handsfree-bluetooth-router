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
//            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [AVAudioSessionCategoryOptions.allowBluetooth])
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeDefault, routeSharingPolicy: .longForm, options: [AVAudioSessionCategoryOptions.allowBluetooth])
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
        var text = ""
        let inputs = audioSession.availableInputs
        inputs?.forEach({ portDesc in
            if portDesc.portType == AVAudioSessionPortBluetoothHFP {
                do {
                    try audioSession.setPreferredInput(portDesc)
                } catch {}
            }
            text.append("Port Type: \(portDesc.portType)\n")
        })
        textArea.text = text
        
        
        
        
        
    }
    
    @IBOutlet weak var textArea: UITextView!
    

}

extension ViewController: AVRoutePickerViewDelegate {
    
}
