//
//  ProgressHUD.swift
//  USU ACCESS
//
//  Created by ev_mac5 on 19/12/15.
//  Copyright © 2015 ev_mac16. All rights reserved.
//

import UIKit

let sharedInstance = ProgressHUD()
let APP_DELEGATE    = UIApplication.shared.delegate as! AppDelegate
class ProgressHUD: UIView {

    var multiColorLoader : BLMultiColorLoader!

    var viewFront : UIView!
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        viewFront = UIView.init(frame: CGRect(x:(UIScreen.main.bounds.size.width-100)/2, y:(UIScreen.main.bounds.size.height-100)/2, width:100, height:100))
        viewFront.backgroundColor = UIColor.white
        viewFront.layer.cornerRadius = 20
        viewFront.layer.masksToBounds = true
        multiColorLoader = BLMultiColorLoader(frame: CGRect(x: 20, y: 20, width:60, height: 60))
        viewFront.addSubview(multiColorLoader)
        self.addSubview(viewFront)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func shared() -> ProgressHUD!
    {
        return sharedInstance
    }
    
    func hide()
    {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
    func show()
    {
        self.frame=UIScreen.main.bounds;
        multiColorLoader.startAnimation()
        if #available(iOS 13.0, *){
            UIApplication.shared.windows.first?.addSubview(self)
        } else {
            APP_DELEGATE.window?.addSubview(self)
        }
    }
}

extension UIWindowScene {
    static var focused: UIWindowScene? {
        return UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive && $0 is UIWindowScene } as? UIWindowScene
    }
}


extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
