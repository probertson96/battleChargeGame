//
//  Character.swift
//  BattleCharge
//
//  Created by Patrick Robertson on 27/10/2015.
//  Copyright © 2015 Patrick Robertson. All rights reserved.
//

import Foundation

class Character {
    private var _hp: Int = 100
    private var _attackPower: Int = 20
    private var _name = ""
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var attackPower: Int {
        get {
            return _attackPower
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var isAlive: Bool {
        if hp <= 0 {
            return false
        } else {
            return true
        }
    }
    
    init(name: String, startingHp: Int, attackPower: Int) {
        self._name = name
        self._hp = startingHp
        self._attackPower = attackPower
    }
    
    func attemptAttack(attackPower: Int) -> Bool {
        self._hp -= attackPower
        
        return true
    }
    
}