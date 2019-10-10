//
//  WeatherDetailViewModel.swift
//  WeatherAppCovrChallenge
//
//  Created by Mehmet Can Seyhan on 2019-10-08.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import Foundation

class WeatherDetailViewModel {
    
    //Variables
    var summary:String!
    var temp:String!
    var humidity:String!
    var wind:String!
    var date:String!
    var imageUrl:String?
    
    //Functions
    init(list: List?) {
        summary = list?.weather?[0].description ?? ""
        date = list?.dt_txt ?? ""
        humidity = (list?.main?.humidity?.description ?? "") + " %"
        wind = (list?.wind?.speed?.description ?? "") + " %"
        temp = (list?.main?.temp?.description ?? "") + "°"
        if let imageIcon = list?.weather?[0].icon {
           imageUrl = Services.WEATHER_IAMGE_URL + imageIcon + "@2x.png"
        }
    }
}
