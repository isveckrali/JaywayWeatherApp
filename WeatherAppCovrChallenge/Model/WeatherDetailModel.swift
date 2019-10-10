//
//  WeatherDetailModel.swift
//  WeatherAppCovrChallenge
//
//  Created by Mehmet Can Seyhan on 2019-07-09.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDetailModel: Decodable {
     var cod:String?
     var message:Double?
     var cnt: Int?
     var list:[List]?
     var city:City?
}

struct List: Decodable {
    var dt: Int?
    var main: Main?
    var weather: [Weather]?
    var clouds: Clouds?
    var wind: Wind?
    var sys: Sys?
    var dt_txt: String?
}

struct Weather: Decodable {
    var description:String?
    var icon:String?
    var id:Int?
    var main:String?
    
   
}

struct Main: Decodable {
    var temp:Double?
    var pressure:Double?
    var humidity:Int?
    var temp_min:Double?
    var temp_max:Double
}

struct Wind: Decodable {
    var speed:Double?
    var deg:Double?
}

struct Clouds: Decodable {
    var all:Int?
    
}

struct Sys: Decodable {
    var pod:String?
}

struct City: Decodable {
    var id:Int?
    var name:String?
    var coord:Coord?
    var country:String?
    var timezone:Int?
    var sunrise:Int?
    var sunset:Int?
}

extension Weather {
    var iconImage: UIImage? {
        switch icon {
        case "01n":
            return UIImage(named: "clear-day")!
        case "01d":
            return UIImage(named: "clear-night")!
        case "09d":
            return UIImage(named: "rain")!
        case "13n":
            return UIImage(named: "snow")!
        case "10d":
            return UIImage(named: "sleet")!
        case "50d":
            return UIImage(named: "wind")!
        case "10n":
            return UIImage(named: "fog")!
        case "04d":
            return UIImage(named: "cloudy")!
        case "03n":
            return UIImage(named: "partly-cloudy")!
        case "04n":
            return UIImage(named: "cloudy-night")!
        default:
            return UIImage(named: "default")!
        }
    }
} 
