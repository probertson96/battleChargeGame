//
//  Player.swift
//  BattleCharge
//
//  Created by Patrick Robertson on 27/10/2015.
//  Copyright © 2015 Patrick Robertson. All rights reserved.
//

import Foundation

class Player: Character {
    
    convenience init(name: String, hp: Int, attackPower: Int) {
        self.init(startingHp: hp, attackPower: attackPower)
        
    }
}