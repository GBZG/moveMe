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
    var sound: NSURL?
    
    func playSilentMusic() {
        sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "silentSound", ofType: "wav")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback,
                mode: AVAudioSession.Mode.default,
                options: [ AVAudioSession.CategoryOptions.duckOthers ]
            )
            
            try AVAudioSession.sharedInstance().setActive(true)
            
            guard let sound = sound else { return }
            
            audioPlayer = try AVAudioPlayer(contentsOf: sound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func playSoundWith(nameWithType: String) {
        playCustomSound(nameWithType)
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}

private extension SoundManager {
    func playCustomSound(_ named: String) {
//        guard let path = Bundle.main.path(forResource: named, ofType: nil) else { return }
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer!.numberOfLoops = -1
//            audioPlayer!.play()
//        } catch {
//            print("Cannot play the file")
//        }
    }
}
