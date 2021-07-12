//
//  Webservice.swift
//  AddressList
//
//  Created by PARTHIBAN on 21/01/19.
//  Copyright © 2019 PARTHIBAN. All rights reserved.
//

import UIKit
enum api:String {
    case signUpUrl = "http://virutchamsoft.com/app/api/v1/users/2679e8084f7611b1a68ab597c5b68f58/signup"
    case loginUrl = "http://virutchamsoft.com/app/api/v1/users/2679e8084f7611b1a68ab597c5b68f58/login"
    case forgotPwd = "http://virutchamsoft.com/app/api/v1/users/2679e8084f7611b1a68ab597c5b68f58/forgotpassword"
    case dashboardUrl = "http://virutchamsoft.com/app/api/v1/track/2679e8084f7611b1a68ab597c5b68f58/1/dashboard"
    case aboutUrl = "http://hindudevotional.in/app_api/about.json"
}

class Webservice: NSObject {
    
    func sinUp(parameters:[String:Any],image:UIImage, completion:@escaping(_ result:Data?, _ err:Error? )->Void){
        // the image in UIImage type
        let filename = "photo.png"
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: URL(string:api.signUpUrl.rawValue)!)
        urlRequest.httpMethod = "POST"
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        for (key, value) in parameters {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)\r\n".data(using: .utf8)!)
        }
          
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"userimage_upload\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        
        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
        // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            
            if(error != nil){
                print("\(error!.localizedDescription)")
                completion(nil,error)
            }
            
            guard let responseData = responseData else {
                print("no response data")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                completion(responseData,nil)
            }
        }).resume()
    }

    func login(param:[String:Any], completion:@escaping(_ result:Data?, _ err:Error? )->Void){
        let url = URL(string: api.loginUrl.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch let e {
            print(e)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            DispatchQueue.main.async {
                if err != nil {
                    completion(nil,err)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    completion(data,nil)
                }
            }
        }.resume()
    }
    
    func forgotPwd(param:[String:Any], completion:@escaping(_ result:Data?, _ err:Error? )->Void){
        let url = URL(string: api.forgotPwd.rawValue)!
       
        var request = URLRequest(url: url)
         request.httpMethod = "POST"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch let e {
            print(e)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            DispatchQueue.main.async {
                if err != nil {
                    completion(nil,err)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    completion(data,nil)
                }
            }
        }.resume()
    }
    
    func getDashboard(completion:@escaping(_ result:Data?, _ err:Error? )->Void){
        let url = URL(string: api.dashboardUrl.rawValue)!
        var request = URLRequest(url: url)
        //request.httpMethod = "POST"
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
//            request.httpBody = jsonData
//        } catch let e {
//            print(e)
//        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            DispatchQueue.main.async {
                if err != nil {
                    completion(nil,err)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    completion(data,nil)
                }
            }
        }.resume()
    }
    
    func getAbout(trackId:String, completion:@escaping(_ result:Data?, _ err:Error? )->Void){
        let url = api.aboutUrl.rawValue
        URLSession.shared.dataTask(with: URL.init(string: url)!){(data,response,err) in
            DispatchQueue.main.async {
                
                if err != nil {
                    completion(nil,err)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    completion(data,nil)
                }
            }
            }.resume()
    }
}

