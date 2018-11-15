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
        myRoutePickerView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        myRoutePickerView.delegate = self
        self.view.addSubview(myRoutePickerView)
        self.view.backgroundColor = UIColor.rgb(red: 24, green: 30, blue: 84)
        
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [.allowBluetooth, .mixWithOthers, .allowBluetoothA2DP])
            try audioSession.setActive(true)
        } catch {
            print(error.localizedDescription)
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
    }
    
    @IBOutlet weak var textArea: UITextView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension ViewController: AVRoutePickerViewDelegate {
    
}
