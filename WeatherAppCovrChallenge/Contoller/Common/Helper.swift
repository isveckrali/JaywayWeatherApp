//
//  Helper.swift
//  WeatherAppCovrChallenge
//
//  Created by Mehmet Can Seyhan on 2019-10-06.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
        //MARK: FUNCTIONS
       
    //Show dialog box
       static func dialogMessage(message:String, vc:UIViewController) {
           let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           vc.present(alert, animated: true, completion: nil)
           
       }
    
    //Load image data from server
    static func imageLoad(imageView:UIImageView, url:String) {
        let downloadTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, urlResponse, error) in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        downloadTask.resume()
    }
}
