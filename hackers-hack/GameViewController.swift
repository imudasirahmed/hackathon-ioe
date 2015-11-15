//  ViewController.swift
import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var monsterImage:MonsterImg!
    @IBOutlet weak var foodImg:DragImageView!
    @IBOutlet weak var heartImg:DragImageView!
    @IBOutlet weak var penatly1:UIImageView!
    @IBOutlet weak var penatly2:UIImageView!
    @IBOutlet weak var penatly3:UIImageView!
    
    // Constant
    let DIM_ALPHA:CGFloat = 0.2
    let OPAQUE:CGFloat = 1.0
    let MAX_PENALTY = 3
    
    var penalties = 0
    var timer:NSTimer!
    var monsterHappy = false
    var currentNeed:UInt32 = 0
    
    var musicPlayer:AVAudioPlayer!
    var sfxBite:AVAudioPlayer!
    var sfxHeart:AVAudioPlayer!
    var sfxDeath:AVAudioPlayer!
    var sfxSkull:AVAudioPlayer!
    
    
    @IBAction func backTapped(sender: AnyObject) {
        musicPlayer.stop()
        sfxBite.stop()
        sfxHeart.stop()
        sfxDeath.stop()
        sfxSkull.stop()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImage
        heartImg.dropTarget = monsterImage
        
        penatly1.alpha = DIM_ALPHA
        penatly2.alpha = DIM_ALPHA
        penatly3.alpha = DIM_ALPHA
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "OnTargetDropped", object: nil)
        
        do {
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: resourcePath))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxDeath.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }
    
    func setNeeds() {
        
        let rand = arc4random_uniform(2)
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        currentNeed = rand
        monsterHappy = false
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func itemDroppedOnCharacter(notif:AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentNeed == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            
            penalties++;
            sfxSkull.play()
            
            if penalties == 1 {
                penatly1.alpha = OPAQUE
                penatly2.alpha = DIM_ALPHA
                penatly3.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penatly1.alpha = OPAQUE
                penatly2.alpha = OPAQUE
                penatly3.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penatly1.alpha = OPAQUE
                penatly2.alpha = OPAQUE
                penatly3.alpha = OPAQUE
            } else {
                penatly1.alpha = DIM_ALPHA
                penatly2.alpha = DIM_ALPHA
                penatly3.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTY {
                gameOver()
            }
        }
        
        // set-needs after 3 seconds
        setNeeds()
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
        sfxDeath.play()
    }
}

