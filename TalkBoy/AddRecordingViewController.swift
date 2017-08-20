//
//  AddRecordingViewController.swift
//  TalkBoy
//
//  Created by Patty Harris on 8/18/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import AVFoundation

class AddRecordingViewController: UIViewController {

    @IBOutlet weak var recordSoundButton: UIButton!
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var addSoundButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    
    var audioURL : URL?
    
    // Private function instaead of copying and pasting this.
    func setControlStateWhileRecording(isEnabled: Bool) {
        playSoundButton.isEnabled = isEnabled
        addSoundButton.isEnabled = isEnabled
        titleTextField.isEnabled = isEnabled

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Create the Audio Session
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // Override the speaker so that it doesn't come out the headset
        try? session.overrideOutputAudioPort(.speaker)
        
        try? session.setActive(true)
        
        // 2. Setup a URL to save the audio recording
        // First we need access to the documents directory.
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let pathComponents = [basePath, "audo.m4a"]
            
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
                
                // Added this to store the URL needed to play the audio.  See below.
                self.audioURL = audioURL
                
                // 3. Create audo settings - set initially to an empty dictionary.
                var settings : [String : Any] = [:]
                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                
                // This sets the quality of the recording
                settings[AVSampleRateKey] = 44100.0
                
                settings[AVNumberOfChannelsKey] = 2

                // 4. Create the Audio Recorder (with a pause here to learn about dictionaries).
                // The constructor takes a [String : Any] dictionary
                audioRecorder = try? AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
            }
        }
        
        // Initially, the other buttons are disabled until a sound is recorded.
        setControlStateWhileRecording(isEnabled: false)
    }

    @IBAction func recordSoundButtonDidTap(_ sender: Any) {
        
        if let audioRecorder = audioRecorder {
            if audioRecorder.isRecording {
                
                audioRecorder.stop()
                
                recordSoundButton.setTitle("Record Sound", for: .normal)
                setControlStateWhileRecording(isEnabled: true)

            }
            else {
                recordSoundButton.setTitle("Stop Recording", for: .normal)
                setControlStateWhileRecording(isEnabled: false)
                
                audioRecorder.record()
            }
        }
    }
    
    @IBAction func playSoundButtonDidTap(_ sender: Any) {
        
        if let audioURL = self.audioURL {
            audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        }
    }
    
    @IBAction func addRecordingDidTap(_ sender: Any) {
        // Get the managed object context
        if let context  =
            ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            
            let item = SoundEntity(entity: SoundEntity.entity(), insertInto: context)
            item.title = titleTextField.text
            
            // TODO - audio data
            if let audioURL = self.audioURL {
                item.audioData = try? Data(contentsOf: audioURL)

                // This can also be handled this way:
                // try? context.save
                // But then there's no handling the failure case...
                // To get the data to "reload" we need to handle
                // viewWillAppear.
                do {
                    try context.save()
                }
                catch {
                    self.showAlert(message: "Data could not be saved!  Please try again.")
                }
                
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // Utility function (not part of tutorial)
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

}
