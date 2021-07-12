//
//  SignUpViewModel.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 05/04/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit
protocol SignUpViewModelDelegate : class{
    func apiError(error:String)
    func startLoading()
    func finishLoading()
}

class SignUpViewModel: NSObject {
    private var webservice :Webservice
    weak var delegate :SignUpViewModelDelegate?
    
    init(webservice :Webservice) {
        self.webservice = webservice
    }
    
    func forgotpassword(param:[String:Any]){
        self.delegate?.startLoading()
        webservice.forgotPwd(param: param) { (data, error) in
            if error != nil
            {
                DispatchQueue.main.async {
                    ProgressHUD.shared().hide()
                }
                self.delegate?.apiError(error: (error?.localizedDescription)!)
            }
            else{
                do {
                    let results = try JSONDecoder().decode(forgotpwdReult.self, from: data!)
                    if results.code == 200{
                        self.delegate?.finishLoading()
                    }
                    else
                    {
                        
                        self.delegate?.apiError(error: results.message!)
                    }
                    print(results)
                } catch let err {
                    print("Err:", err)
                    self.delegate?.apiError(error: err.localizedDescription)
                }
            }
        }
    }
    
    func login(param:[String:Any]){
        self.delegate?.startLoading()
        webservice.login(param: param) { (data, error) in
            if error != nil
            {
                DispatchQueue.main.async {
                    ProgressHUD.shared().hide()
                }
                self.delegate?.apiError(error: (error?.localizedDescription)!)
            }
            else{
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        // try to read out a string array
                        print("responds:",json)
                        if let names = json["user_info"] as? [String:Any] {
                            do {
                                let results = try JSONDecoder().decode(loginReult.self, from: data!)
                                if results.code == 200{
                                    Userdefault.shared.setUserID(data: Int((results.user_info.id)!)!)
                                    self.delegate?.finishLoading()
                                }
                                else
                                {
                                    
                                    self.delegate?.apiError(error: results.message!)
                                }
                                print(results)
                            } catch let err {
                                print("Err:", err)
                                self.delegate?.apiError(error: err.localizedDescription)
                            }
                        }
                        else
                        {
                            do {
                                let results = try JSONDecoder().decode(loginError.self, from: data!)
                                if results.code == 200{
                                    self.delegate?.finishLoading()
                                }
                                else
                                {
                                    
                                    self.delegate?.apiError(error: results.message!)
                                }
                                print(results)
                            } catch let err {
                                print("Err:", err)
                                self.delegate?.apiError(error: err.localizedDescription)
                            }
                        }
                    }
                }
                catch let err {
                    print("Err:", err)
                    self.delegate?.apiError(error: err.localizedDescription)
                }
                
            }
        }
    }
    
    func signUp(param:[String:Any], image:UIImage){
        self.delegate?.startLoading()
        print("request:",param)
        webservice.sinUp(parameters: param, image: image) { (data, error) in
            if error != nil
            {
                DispatchQueue.main.async {
                    ProgressHUD.shared().hide()
                }
                self.delegate?.apiError(error: (error?.localizedDescription)!)
            }
            else
            {
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        // try to read out a string array
                        print("responds:",json)
                        if let names = json["user_info"] as? [String:Any] {
                            print(names)
                            print(json)
                            do {
                                let results = try JSONDecoder().decode(loginReult.self, from: data!)
                                if results.code == 200{
                                    Userdefault.shared.setUserID(data: Int((results.user_info.id)!)!)
                                    self.delegate?.finishLoading()
                                }
                                else
                                {
                                    
                                    self.delegate?.apiError(error: results.message!)
                                }
                                
                                print(results)
                            } catch let err {
                                print("Err:", err)
                                self.delegate?.apiError(error: err.localizedDescription)
                            }
                        }
                        else
                        {
                            do {
                                let results = try JSONDecoder().decode(signResult.self, from: data!)
                                if results.code == 200{
                                    Userdefault.shared.setUserID(data: results.UserId!)
                                    self.delegate?.finishLoading()
                                }
                                else
                                {
                                    
                                    self.delegate?.apiError(error: results.message!)
                                }
                                
                                print(results)
                            } catch let err {
                                print("Err:", err)
                                self.delegate?.apiError(error: err.localizedDescription)
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    self.delegate?.apiError(error: error.localizedDescription)
                }
            }
        }
    }
}

