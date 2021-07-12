//
//  Model.swift
//  AddressList
//
//  Created by PARTHIBAN on 21/01/19.
//  Copyright © 2019 PARTHIBAN. All rights reserved.
//
enum Platform: Int {
    case Backend = 1
    case iOS = 2
    case Android = 3
}

enum Registertype: Int {
    case Normal = 1
    case Social = 2
}

enum Socialtype: Int {
    case Facebook = 1
    case Google = 2
}

import UIKit

struct signInDetail: Codable {
    var firstname : String?
    var lastname : String?
    var username : String?
    var password : String?
    var emailaddress : String?
    var platform : Int?
    var deviceid : String?
    var registertype : Int?
    var socialtype : Int?
    var socialid : String?
}

struct signResult: Codable {
    var UserId : Int?
    var status : String?
    var code : Int?
    var message : String?
}

struct loginReult: Codable {
    var message : String?
    var code : Int?
    var user_info = userInfo()
    var status : String?
}

struct loginError: Codable {
    var message : String?
    var code : Int?
    var status : String?
}

struct userInfo: Codable {
    var emailaddress : String?
    var id:String?
    var userimage : String?
    var username : String?
}

struct forgotpwdReult: Codable {
    var message : String?
    var code : Int?
    var status : String?
}

struct dashboardReult: Codable {
    var string : Int?
    var status : String?
    var code : Int?
    var message : String?
    var album_list  = [albumlist]()
    var album_category_list = [albumcategorylist]()
    var video_category_list = [videocategorylist]()
    var popular_track_list = [populartracklist]()
}

struct albumlist: Codable {
    var album_id : String?
    var album_name : String?
    var album_image : String?
}

struct albumcategorylist: Codable {
    var album_id : String?
    var album_category_id : String?
    var album_category_name : String?
    var album_category_image : String?
}

struct videocategorylist: Codable {
    var video_categoryid : String?
    var video_categoryname : String?
    var video_categoryimage : String?
}

struct populartracklist: Codable {
    var track_id : String?
    var album_id : String?
    var album_name : String?
    var album_category_id : String?
    var album_category_name : String?
    var artist_id = String()
    var track_title : String?
    var mp3 : String?
    var track_description : String?
    var track_lyrics : String?
    var track_viewedcounts : String?
    var track_playcounts : String?
    var track_dateupdated : String?
    var isfavorite : Int?
    var track_smallimage : String?
}
