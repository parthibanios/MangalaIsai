//
//  BLMultiColorLoader.swift
//  USU ACCESS
//
//  Created by ev_mac5 on 18/12/15.
//  Copyright © 2015 ev_mac16. All rights reserved.
//

import UIKit

class BLMultiColorLoader: UIView {

    var theColorArray : NSArray!
    var lineWidth : CGFloat!
    var circleLayer : CAShapeLayer!
    var strokeLineAnimation : CAAnimationGroup!
    var rotationAnimation : CAAnimation!
    var strokeColorAnimation : CAAnimation!
    var animating : Bool!

    let DEFAULT_LINE_WIDTH : CGFloat =  2.0
    let ROUND_TIME =  1.33 as Double
    
    let DEFAULT_COLOR1 =  UIColor.yellow.cgColor
    let DEFAULT_COLOR2 =  UIColor.magenta.cgColor
    let DEFAULT_COLOR3 =  UIColor.orange.cgColor
    let DEFAULT_COLOR4 =  UIColor.purple.cgColor 

    override init(frame:CGRect) {
        super.init(frame:frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
        fatalError("init(coder:) has not been implemented")
    }

    func initialSetup()
    {
        circleLayer = CAShapeLayer()
        self.layer.addSublayer(circleLayer)
        
        self.backgroundColor = UIColor.clear
        circleLayer.fillColor = nil
        self.circleLayer.lineWidth = DEFAULT_LINE_WIDTH
        self.circleLayer.lineCap = CAShapeLayerLineCap.round;
        
        theColorArray = [DEFAULT_COLOR1, DEFAULT_COLOR2, DEFAULT_COLOR3, DEFAULT_COLOR4]
        
        self.updateAnimations()
    }
    
    // Mark: - Layout
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let center = CGPoint(x:self.bounds.size.width / 2.0, y:self.bounds.size.height / 2.0)
        let radius = min(self.bounds.size.width, self.bounds.size.height)/2.0 - self.circleLayer.lineWidth / 2.0
        let startAngle = 0.0 as CGFloat
        let endAngle = 2 * M_PI
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: CGFloat(endAngle), clockwise: true)

        self.circleLayer.path = path.cgPath;
        self.circleLayer.frame = self.bounds;
    }
    
     // Mark: -
    
    func startAnimation()
    {
        animating = true;
        self.circleLayer.add(self.strokeLineAnimation, forKey: "strokeLineAnimation")
        self.circleLayer.add(self.rotationAnimation, forKey: "rotationAnimation")
        self.circleLayer.add(self.strokeColorAnimation, forKey: "strokeColor")
    }
    
    func stopAnimation()
    {
        animating = false;
        self.circleLayer.removeAnimation( forKey: "strokeLineAnimation")
        self.circleLayer.removeAnimation( forKey: "rotationAnimation")
        self.circleLayer.removeAnimation( forKey: "strokeColor")
    }
    
    func updateAnimations()
    {
        // Stroke Head
        let headAnimation = CABasicAnimation(keyPath: "strokeStart")
        headAnimation.beginTime = ROUND_TIME/3.0
        headAnimation.fromValue = 0
        headAnimation.toValue = 1
        headAnimation.duration = 2*ROUND_TIME/3.0
        headAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        // Stroke Tail
        let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tailAnimation.fromValue = 0
        tailAnimation.toValue = 1
        tailAnimation.duration = 2*ROUND_TIME/3.0
        tailAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        // Stroke Line Group
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = ROUND_TIME
        animationGroup.repeatCount = Float.infinity
        animationGroup.animations = [headAnimation, tailAnimation]
        self.strokeLineAnimation = animationGroup
        
        // Rotation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2*M_PI
        rotationAnimation.duration = 2*ROUND_TIME/3.0
        animationGroup.repeatCount = Float.infinity
        self.rotationAnimation = rotationAnimation;
        
        let strokeColorAnimation = CABasicAnimation(keyPath: "strokeColor")
        strokeColorAnimation.fromValue = theColorArray[0]
        strokeColorAnimation.toValue = theColorArray[3]
        strokeColorAnimation.duration = Double(theColorArray.count) * ROUND_TIME
        strokeColorAnimation.repeatCount = Float.infinity
        self.strokeColorAnimation = strokeColorAnimation
    }
    
     deinit
    {
        stopAnimation()
        self.circleLayer.removeFromSuperlayer()
        self.circleLayer = nil;
        self.strokeLineAnimation = nil;
        self.rotationAnimation = nil;
        self.strokeColorAnimation = nil;
        theColorArray = nil;
    }
}

