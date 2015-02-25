//
//  DynamicAnimationView.swift
//  swift sample
//
//  Created by wangkun on 15/2/24.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

import UIKit

class DynamicAnimationView: UIView, UIDynamicAnimatorDelegate{
    var animator : UIDynamicAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 50.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.redColor()
        self.hidden = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func gravityAnimation(){
        //reset
        self.resetAnimator()
        
        //gravity
        var gravityBehavior = UIGravityBehavior(items: [self])
        gravityBehavior.gravityDirection = CGVectorMake(0.2, 0.8)
        //boundary
        var boundary = UICollisionBehavior(items: [self])
        boundary.translatesReferenceBoundsIntoBoundary = true
        
        //bounce
        var itemBehavior = UIDynamicItemBehavior(items: [self])
        itemBehavior.elasticity = 0.9
        
        self.animator?.addBehavior(gravityBehavior)
        self.animator?.addBehavior(boundary)
        self.animator?.addBehavior(itemBehavior)
    }
    
    func pushAnimation(){
        self.resetAnimator()
        //push
        var pushBehavior = UIPushBehavior(items: [self], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(45, 0);
        pushBehavior.magnitude = 1.0;
        //boundary
        var boundary = UICollisionBehavior(items: [self])
        boundary.translatesReferenceBoundsIntoBoundary = true
        
        //bounce
        var itemBehavior = UIDynamicItemBehavior(items: [self])
        itemBehavior.elasticity = 0.9
        
        self.animator?.addBehavior(pushBehavior)
        self.animator?.addBehavior(boundary)
        self.animator?.addBehavior(itemBehavior)
    }
    
    func snapAnimation(){
        self.resetAnimator()
        
        //snap
        var snapBehavior = UISnapBehavior(item: self, snapToPoint: CGPointMake(200, 200))
        snapBehavior.damping = 0.3;
        
        //boundary
        var boundary = UICollisionBehavior(items: [self])
        boundary.translatesReferenceBoundsIntoBoundary = true
        
        //bounce
        var itemBehavior = UIDynamicItemBehavior(items: [self])
        itemBehavior.elasticity = 0.9
        
        self.animator?.addBehavior(snapBehavior)
        self.animator?.addBehavior(boundary)
        self.animator?.addBehavior(itemBehavior)
    }
    
    func resetAnimator(){
        self.hidden = false;
        //reset
        self.animator?.removeAllBehaviors()
        
        self.animator = UIDynamicAnimator(referenceView: self.superview!)
        self.animator?.delegate = self
    }
    
    //MARK : UIDynamicAnimatorDelegate
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator){
        self.hidden = true
    }
    
}
