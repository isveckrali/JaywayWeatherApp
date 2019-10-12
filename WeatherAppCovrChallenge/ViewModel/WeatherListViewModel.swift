//
//  WeatherListModelView.swift
//  WeatherAppCovrChallenge
//
//  Created by Mehmet Can Seyhan on 2019-10-08.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import Foundation

class WeatherListModelView {
    
    var name:String!
    var text:String!
    
    init(weatherListModel: WeatherListModel?) {
        name = weatherListModel?.name ?? ""
        text = weatherListModel?.country ?? ""
    }
}
