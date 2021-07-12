//
//  SettingsVC.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 08/12/19.
//  Copyright © 2019 PARTHIBAN. All rights reserved.
//

import UIKit

class SettingsVC: NSObject {

}

extension UIView
{
    func setBackgroudImage(_ size:CGSize?)
    {
        var size = size
        if size == nil
        {
            size = self.bounds.size
        }
      
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: size!.width, height: size!.height))
        backgroundImage.image = UIImage(named: "backGround")
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.tag = 88
        if self.subviews.count > 0
        {
            if let imageView = self.subviews[0] as? UIImageView, imageView.tag == 88
            {
                self.subviews[0].removeFromSuperview()
            }
        }
        self.insertSubview(backgroundImage, at: 0)
    }
}

extension UIViewController
{
    func setBackgroudImage(_ size:CGSize?)
    {
        var size = size
        if size == nil
        {
            size = self.view.bounds.size
        }
        
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: size!.width, height: size!.height))
        backgroundImage.image = UIImage(named: "backGround")
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.tag = 88
        if self.view.subviews.count > 0
        {
            if let imageView = self.view.subviews[0] as? UIImageView, imageView.tag == 88
            {
                self.view.subviews[0].removeFromSuperview()
            }
        }
        self.view.insertSubview(backgroundImage, at: 0)
    }
}


extension UIColor {

    public class var appColorPink: UIColor {
        return self.hexColor(0xD2366F, alpha: 1.0)
    }

    class func hexColor(_ hexColorNumber:UInt32, alpha: CGFloat) -> UIColor {
        let red = (hexColorNumber & 0xff0000) >> 16
        let green = (hexColorNumber & 0x00ff00) >> 8
        let blue =  (hexColorNumber & 0x0000ff)
        return self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
        
    }
}


extension UIView {
    
    // different inner shadow styles
    public enum innerShadowSide
    {
        case all, left, right, top, bottom, topAndLeft, topAndRight, bottomAndLeft, bottomAndRight, exceptLeft, exceptRight, exceptTop, exceptBottom
    }
    
    // define function to add inner shadow
    public func addInnerShadow(onSide: innerShadowSide, shadowColor: UIColor, shadowSize: CGFloat, cornerRadius: CGFloat = 0.0, shadowOpacity: Float)
    {
        // define and set a shaow layer
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowSize
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        // define shadow path
        let shadowPath = CGMutablePath()
        
        // define outer rectangle to restrict drawing area
        let insetRect = bounds.insetBy(dx: -shadowSize * 2.0, dy: -shadowSize * 2.0)
        
        // define inner rectangle for mask
        let innerFrame: CGRect = { () -> CGRect in
            switch onSide
            {
            case .all:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
            case .left:
                return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
            case .right:
                return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
            case .top:
                return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
            case.bottom:
                return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
            case .topAndLeft:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .topAndRight:
                return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .bottomAndLeft:
                return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .bottomAndRight:
                return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
            case .exceptLeft:
                return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
            case .exceptRight:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
            case .exceptTop:
                return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
            case .exceptBottom:
                return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
            }
        }()
        
        // add outer and inner rectangle to shadow path
        shadowPath.addRect(insetRect)
        shadowPath.addRect(innerFrame)
        
        // set shadow path as show layer's
        shadowLayer.path = shadowPath
        
        // add shadow layer as a sublayer
        layer.addSublayer(shadowLayer)
        
        // hide outside drawing area
        clipsToBounds = true
    }

func addShadowView() {
    //Remove previous shadow views
    superview?.viewWithTag(119900)?.removeFromSuperview()

    //Create new shadow view with frame
    let shadowView = UIView(frame: frame)
    shadowView.tag = 119900
    shadowView.layer.shadowColor = UIColor.black.cgColor
    shadowView.layer.shadowOffset = CGSize(width: 2, height: 3)
    shadowView.layer.masksToBounds = false

    shadowView.layer.shadowOpacity = 0.3
    shadowView.layer.shadowRadius = 3
    shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    shadowView.layer.rasterizationScale = UIScreen.main.scale
    shadowView.layer.shouldRasterize = true

    superview?.insertSubview(shadowView, belowSubview: self)
}
 
    func addShadow(_ radius:CGFloat = 4)
    {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4

//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
        
//        var shadow = UIView(frame: self.frame)//[[UIView alloc] initWithFrame:shadowFrame];
//        shadow.isUserInteractionEnabled = false; // Modify this if needed
//        shadow.layer.shadowColor = UIColor.black.cgColor
//        shadow.layer.shadowOffset = CGSize.zero
//        shadow.layer.shadowRadius = radius
//        shadow.layer.masksToBounds = false
//        shadow.clipsToBounds = false
//        shadow.layer.shadowOpacity = 0.1
//        self.superview?.insertSubview(shadow, belowSubview: self)
//        shadow.addSubview(self)
    }
}

class SimpleShadowedView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

    }
    
    
}



class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(netHex: 0xDD3C6D).cgColor, UIColor(netHex: 0xEB9D47).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
    }
}

class GradientButton: UIButton {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(netHex: 0xDD3C6D).cgColor, UIColor(netHex: 0xEB9D47).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


