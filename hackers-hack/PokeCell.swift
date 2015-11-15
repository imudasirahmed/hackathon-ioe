//
//  PokeCell.swift
//  hackers-hack
//
//  Created by Mudasir Ahmed on 11/15/15.
//  Copyright © 2015 Mudasir Ahmed. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {

    @IBOutlet var thumbImage:UIImageView!
    @IBOutlet var nameLabel:UILabel!
    
    var pokemon:Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon:Pokemon) {
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
