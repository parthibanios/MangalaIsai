//
//  DashboardViewModel.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 18/06/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit
protocol DashboardViewModelDelegate : class{
    func apiError(error:String)
    func startLoading()
    func finishLoading()
}

class DashboardViewModel: NSObject {
    private var webservice :Webservice
    weak var delegate :DashboardViewModelDelegate?
    var dashboardDetail = dashboardReult()
    public var numberOfRowsInSection:Int{
        return ((dashboardDetail.album_list.count > 0 ? 1:0) + self.getUniqueIDsFromArrayOfObjects(events: dashboardDetail.album_category_list).count + (dashboardDetail.video_category_list.count > 0 ? 1:0) + (dashboardDetail.popular_track_list.count > 0 ? 1:0))
    }
    
    public var albumTitleList:[String]{
        var TitleList = [String]()
        if dashboardDetail.popular_track_list.count > 0{
            TitleList.append("Popular Songs")
        }
        let albumIdList = self.getUniqueIDsFromArrayOfObjects(events: dashboardDetail.album_category_list)
        for i in 0..<albumIdList.count {
            let album = dashboardDetail.album_list.filter({$0.album_id == albumIdList[i]}).first
            TitleList.append((album?.album_name)!)
        }
        if dashboardDetail.video_category_list.count > 0{
            TitleList.append("Video Songs")
        }
        return TitleList
    }
    
    
    
    init(webservice :Webservice) {
        self.webservice = webservice
    }

    func getDashbaordDetails(){
        self.delegate?.startLoading()
        webservice.getDashboard() { (data, error) in
            if error != nil
            {
                DispatchQueue.main.async {
                    ProgressHUD.shared().hide()
                }
                self.delegate?.apiError(error: (error?.localizedDescription)!)
            }
            else{
                do {
                    let results = try JSONDecoder().decode(dashboardReult.self, from: data!)
                    if results.code == 200{
                        self.dashboardDetail = results
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
    
    func getUniqueIDsFromArrayOfObjects(events:[albumcategorylist])->[String]
    {
        let eventIds = events.map { $0.album_id!}
        let idset = Set(eventIds)
        return Array(idset)
    }
}
