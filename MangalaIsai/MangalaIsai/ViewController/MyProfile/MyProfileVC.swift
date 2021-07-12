//
//  MyProfileVC.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 02/02/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {

    //@IBOutlet var imgViewHeight: NSLayoutConstraint!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var baseView: UIView!
    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet var btnSignOut: UIButton!
    var gradientLayer: CAGradientLayer!
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        baseView.addShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        baseView.layer.cornerRadius = baseView.frame.height/2
        profileImgView.layer.cornerRadius = profileImgView.frame.height/2
        btnSignOut.layer.cornerRadius = btnSignOut.frame.height/2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: User Define Methods
extension MyProfileVC{
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        //self.setBackgroudImage(self.view!.frame.size)
        self.updateImageHeight()
    }
    
    func setUpUI(){
       // self.setBackgroudImage(self.view!.frame.size)
        self.updateImageHeight()
    }
    
    func updateImageHeight()
    {
       // imgViewHeight.constant = UIScreen.main.bounds.height > UIScreen.main.bounds.width ?  UIScreen.main.bounds.height * 0.38 :  UIScreen.main.bounds.width * 0.38
    }
}
