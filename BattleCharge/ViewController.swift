//
//  ViewController.swift
//  BattleCharge
//
//  Created by Patrick Robertson on 27/10/2015.
//  Copyright © 2015 Patrick Robertson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playerOneHpLabel: UILabel!
    @IBOutlet weak var playerTwoHpLabel: UILabel!
    
    @IBOutlet weak var printLabel: UILabel!
    
    @IBOutlet weak var playerOneImage: UIImageView!
    @IBOutlet weak var playerTwoImage: UIImageView!
    
    @IBOutlet weak var playerOneAttackButton: UIButton!
    @IBOutlet weak var playerTwoAttackButton: UIButton!
    
    @IBOutlet weak var restartButton: UIButton!
    
    
    var playerOne: Player!
    var playerTwo: Player!
    
    var bgMusic: AVAudioPlayer!
    var playerOneHitSound: AVAudioPlayer!
    var playerTwoHitSound: AVAudioPlayer!
    var winnerMusic: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerOneAttackSoundPath = NSBundle.mainBundle().pathForResource("playerOneHit", ofType: "wav")
        let playerOneAttackSoundUrl = NSURL(fileURLWithPath: playerOneAttackSoundPath!)
        
        do {
            try playerOneHitSound = AVAudioPlayer(contentsOfURL: playerOneAttackSoundUrl)
            playerOneHitSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let playerTwoAttackSoundPath = NSBundle.mainBundle().pathForResource("playerTwoHit", ofType: "wav")
        let playerTwoAttackSoundUrl = NSURL(fileURLWithPath: playerTwoAttackSoundPath!)
        
        do {
            try playerTwoHitSound = AVAudioPlayer(contentsOfURL: playerTwoAttackSoundUrl)
            playerTwoHitSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        let path = NSBundle.mainBundle().pathForResource("bgmusic", ofType: "mp3")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try bgMusic = AVAudioPlayer(contentsOfURL: soundUrl)
            bgMusic.prepareToPlay()
            bgMusic.numberOfLoops = -1
            bgMusic.play()
            bgMusic.volume = 0.2
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let winnerPath = NSBundle.mainBundle().pathForResource("winner", ofType: "wav")
        let winnerSoundUrl = NSURL(fileURLWithPath: winnerPath!)
        
        do {
            try winnerMusic = AVAudioPlayer(contentsOfURL: winnerSoundUrl)
            winnerMusic.prepareToPlay()
            winnerMusic.volume = 0.2
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        initialisePlayers()

    }
    
    
    @IBAction func onPlayerOneAttackPressed(sender: AnyObject) {
        if playerTwo.attemptAttack(playerOne.attackPower) {
            playPlayerOneAttackSound()
            printLabel.text = "\(playerOne.name) attacks \(playerTwo.name) for \(playerOne.attackPower) HP"
            playerTwoHpLabel.text = "HP: \(playerTwo.hp)"
            playerTwoAttackButton.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "renablePlayerTwoAttackButton", userInfo: nil, repeats: false)
            
        } else {
            printLabel.text = "Attack was unsuccessful"
        }
        
        if !playerTwo.isAlive {
            stopPlayingBgMusic()
            playWinningMusic()
            playerTwoImage.hidden = true
            playerTwoHpLabel.text = "HP: 0"
            printLabel.text = "\(playerTwo.name) was killed by \(playerOne.name)"
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "winTextPlayerOne", userInfo: nil, repeats: false)
            
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "unhideRestartButton", userInfo: nil, repeats: false)
            
        }
    }

    
    @IBAction func onPlayerTwoAttackPressed(sender: AnyObject) {
        if playerOne.attemptAttack(playerTwo.attackPower) {
            playPlayerTwoAttackSound()
            printLabel.text = "\(playerTwo.name) attacks \(playerOne.name) for \(playerTwo.attackPower) HP"
            playerOneHpLabel.text = "HP: \(playerOne.hp)"
            playerOneAttackButton.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "renablePlayerOneAttackButton", userInfo: nil, repeats: false)
        } else {
            printLabel.text = "Attack was unsuccessful"
        }
        
        if !playerOne.isAlive {
            stopPlayingBgMusic()
            playWinningMusic()
            playerOneImage.hidden = true
            playerOneHpLabel.text = "HP: 0"
            printLabel.text = "\(playerOne.name) was killed by \(playerTwo.name)"
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "winTextPlayerTwo", userInfo: nil, repeats: false)
            
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "unhideRestartButton", userInfo: nil, repeats: false)
        }

    }
    
    @IBAction func onRestartButtonPressed(sender: AnyObject) {
        restartGame()
    }
    
    
    func winTextPlayerOne() {
        printLabel.text = "\(playerOne.name) wins!"
    }
    
    func winTextPlayerTwo() {
        printLabel.text = "\(playerTwo.name) wins!"
    }
    
    func renablePlayerTwoAttackButton() {
        playerTwoAttackButton.enabled = true
    }
    
    func renablePlayerOneAttackButton() {
        playerOneAttackButton.enabled = true
    }
    
    func playPlayerOneAttackSound() {
        playerOneHitSound.play()
    }
    
    func playPlayerTwoAttackSound() {
        playerTwoHitSound.play()
    }
    
    func stopPlayingBgMusic() {
        bgMusic.stop()
    }
    
    func playWinningMusic() {
        winnerMusic.play()
        winnerMusic.numberOfLoops = -1
    }
    
    func unhideRestartButton() {
        restartButton.hidden = false
    }
    
    func restartGame() {
        winnerMusic.stop()
        bgMusic.play()
        
        if playerTwoImage.hidden == true {
            playerTwoImage.hidden = false
            initialisePlayers()
            
        } else if playerOneImage.hidden == true {
            playerOneImage.hidden = false
            initialisePlayers()
        }
        
        restartButton.hidden = true
        
    }
    
    func initialisePlayers() {
        playerOne = Player(name: "Player 1", hp: 100, attackPower: 20)
        playerTwo = Player(name: "Player 2", hp: 100, attackPower: 20)
        
        playerOneHpLabel.text = "HP: \(playerOne.hp)"
        playerTwoHpLabel.text = "HP: \(playerTwo.hp)"
        
        printLabel.text = "\(playerOne.name) encounters \(playerTwo.name)"
    }

}

