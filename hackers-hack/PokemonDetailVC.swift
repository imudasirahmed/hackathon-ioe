//
//  PokemonDetailVC.swift
//  hackers-hack
//
//  Created by Mudasir Ahmed on 11/15/15.
//  Copyright © 2015 Mudasir Ahmed. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var poke:Pokemon!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var mainImage: UIImageView!
    
    let steps = ["Did you ask city permission", "Did you buy grade A seeds?", "Add Water to the grass", "Sprikle some Jelly", "Add some code", "Spray paint the yard", "Eat food?", "Block TV"]
    
    @IBAction func backTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = poke.name
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.mainImage.image = UIImage(named:"\(poke.pokedexId)")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 86.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("StepsCell", forIndexPath: indexPath) as? StepsCell {
            let rand = Int(arc4random_uniform(UInt32(2)))
            if rand == 0 {
                cell.configureCell(steps[indexPath.row], image: UIImage(named: "depot")!)
            } else {
                cell.configureCell(steps[indexPath.row], image: UIImage(named: "ace")!)
            }
            return cell;
        } else {
            return StepsCell()
        }
    }
}
