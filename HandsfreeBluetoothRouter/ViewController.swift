//
//  ViewController.swift
//  HandsfreeBluetoothRouter
//
//  Created by Ryan Walker on 10/12/17.
//  Copyright © 2017 Ryan Walker. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioSession = AVAudioSession()
        
        do {
             try audioSession.setCategory(AVAudioSessionCategoryMultiRoute)
            try audioSession.setActive(true)
            print(audioSession.currentRoute.outputs)
            print(audioSession.outputDataSources)
        } catch is Error {
            print("error")
        }
        
        //https://stackoverflow.com/questions/15643516/list-available-output-audio-target-avaudiosession
        print(audioSession.currentRoute)
//        audioSession.setCategory(AVAudioSessionCategorySoloAmbient, AVAudioSessionCategoryOptions.allowBluetooth)
        print(audioSession.availableCategories)
        print(audioSession.categoryOptions)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

