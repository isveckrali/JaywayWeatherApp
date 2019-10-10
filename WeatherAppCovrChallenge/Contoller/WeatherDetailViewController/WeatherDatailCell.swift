//
//  WeatherDatailCell.swift
//  WeatherAppCovrChallenge
//
//  Created by Mehmet Can Seyhan on 2019-10-08.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit
    
class WeatherDatailCell: UITableViewCell {

    //IBOutlets
    @IBOutlet var lblSummary: UILabel!
    @IBOutlet var LblTemp: UILabel!
    @IBOutlet var lblHumidity: UILabel!
    @IBOutlet var lblWind: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var imgViewWeather: UIImageView!
    
    //Variables
    var list:WeatherDetailViewModel? {
        didSet {
            lblDate.text = list?.date
            LblTemp.text = list?.temp
            lblHumidity.text = list?.humidity
            lblWind.text = list?.wind
            lblSummary.text = list?.summary
            if let imageUrl = list?.imageUrl {
                Helper.imageLoad(imageView: imgViewWeather, url: imageUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
