//
//  Pokemon.swift
//  hackers-hack
//
//  Created by Mudasir Ahmed on 11/15/15.
//  Copyright © 2015 Mudasir Ahmed. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name:String!
    private var _pokedexId:Int!
    
    var name:String {
        return _name
    }
    
    var pokedexId:Int {
        return _pokedexId
    }
    
    init(name:String, pokedexId:Int) {
        _name = name
        _pokedexId = pokedexId
    }
    
}