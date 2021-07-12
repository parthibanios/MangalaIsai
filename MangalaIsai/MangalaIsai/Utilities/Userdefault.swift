//
//  Userdefaults.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 18/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit
class Userdefault: NSObject {

     static let shared = Userdefault()
      static let defaults = UserDefaults.standard
    
    func setUserID(data:Int)
    {
        Userdefault.defaults.set(data, forKey: "UserId")
    }
    
   func getUserID()-> Int
    {
        guard let userId =  Userdefault.defaults.object(forKey: "UserId")else {
            return 0
        }
        return userId as! Int
    }
    
    func setDeviceId(data:String)
    {
        Userdefault.defaults.set(data, forKey: "DeviceId")
    }
    
    func getDeviceId()-> String
    {
        guard let userId =  Userdefault.defaults.object(forKey: "DeviceId")else {
            return ""
        }
        return userId as! String
    }
}
