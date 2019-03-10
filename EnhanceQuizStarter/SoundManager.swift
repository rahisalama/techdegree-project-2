//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Rahi on 10/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//
import UIKit
import AudioToolbox

class PlaySounds {
    
     static var gameSound: SystemSoundID = 0
    
    static func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    static func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    

    
}
