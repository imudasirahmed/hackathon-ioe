//
//  DragImage.swift
//  gigapet
//
//  Created by Mudasir Ahmed on 11/10/15.
//  Copyright © 2015 Mudasir Ahmed. All rights reserved.
//

import Foundation
import UIKit

class DragImageView : UIImageView {
    
    var originalPos:CGPoint!
    var dropTarget:UIView?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPos = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview)
            if CGRectContainsPoint(target.frame, position) {
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "OnTargetDropped", object: nil))
            }
        }
        self.center = originalPos
    }
}
