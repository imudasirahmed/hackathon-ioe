//
//  PokemonDetailVC.swift
//  hackers-hack
//
//  Created by Mudasir Ahmed on 11/15/15.
//  Copyright © 2015 Mudasir Ahmed. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var poke:Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = poke.name
    }
    
}
