//
//  ViewController.swift
//  BattleCharge
//
//  Created by Patrick Robertson on 27/10/2015.
//  Copyright © 2015 Patrick Robertson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerOneHpLabel: UILabel!
    @IBOutlet weak var playerTwoHpLabel: UILabel!
    
    @IBOutlet weak var printLabel: UILabel!
    
    @IBOutlet weak var playerOneImage: UIImageView!
    @IBOutlet weak var playerTwoImage: UIImageView!
    
    
    var playerOne: Player!
    var playerTwo: Player!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerOne = Player(name: "Player 1", hp: 100, attackPower: 20)
        playerTwo = Player(name: "Player 2", hp: 100, attackPower: 20)
        
        playerOneHpLabel.text = "HP: \(playerOne.hp)"
        playerTwoHpLabel.text = "HP: \(playerTwo.hp)"

    }
    
    
    @IBAction func onPlayerOneAttackPressed(sender: AnyObject) {
    }

    
    @IBAction func onPlayerTwoAttackPressed(sender: AnyObject) {
    }

}

