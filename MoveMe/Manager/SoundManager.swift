//
//  SoundManager.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation
import AVFoundation

class SoundManager {
    static let instance = SoundManager()
    var audioPlayer: AVAudioPlayer?
    
    func playSilentMusic() {
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "silentSound", ofType: "wav")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback,
                mode: AVAudioSession.Mode.default,
                options: [ AVAudioSession.CategoryOptions.duckOthers ]
            )

            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: sound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func playAlarmMusic() {
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "eveningOnTheBeach", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback,
                mode: AVAudioSession.Mode.default,
                options: [ AVAudioSession.CategoryOptions.duckOthers ]
            )

            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: sound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    
    func checkCurrentMusic() -> String {
        guard let audioPlayer = audioPlayer else { return "" }
        return "\(audioPlayer.duration)"
    }
}
