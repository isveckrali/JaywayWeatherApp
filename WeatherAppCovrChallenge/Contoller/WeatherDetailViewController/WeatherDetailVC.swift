//
//  WeatherDetailVC.swift
//  WeatherAppCovrChallenge
//
//  Created by Mehmet Can Seyhan on 2019-07-09.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit
import Alamofire

class WeatherDetailVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
 
    //IBOutlets
    @IBOutlet var tableViewWeatherDetail: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //Variables
    var cityId:Int?
    var cityName:String?
    var weatherDetailModel: WeatherDetailModel?
    var listViewDetailDelegate:ListViewDetailDelegate!
    
    //Constants
    let DETAIL_TABLE_VIEW_REUSE_IDENTIFIER:String = "cellDetailTableView"
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setFirstValueAndCallFuncs()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return weatherDetailModel?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DETAIL_TABLE_VIEW_REUSE_IDENTIFIER) as! WeatherDatailCell
        cell.list = WeatherDetailViewModel(list: weatherDetailModel?.list![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //set first values and call functions
    func setFirstValueAndCallFuncs() {
        self.title = cityName
        preConditions()
    }
    
 
    //check whether city id is empty
    func preConditions() {
        guard cityId != nil else {
            self.navigationController?.popViewController(animated: true)
            self.listViewDetailDelegate.createAlert(message: "City id is empty", title: "Warning")
            //call prepage and crate alert view to user for empty id
            return
        }
         checkInternetConnectionAndGetData()
    }
    
    //Get data from server or close page and show alert to user
    func checkInternetConnectionAndGetData() {
        if InternetController.isConnectedToNetwork() {
            getDataFromServer(url: (Services.WEATHER_DETAIL_URL + cityId!.description + "&appid=" + Services.API_KEY))
        } else {
                self.navigationController?.popViewController(animated: true)
                self.listViewDetailDelegate.createAlert(message: "Please check your internet connection", title: "Warning")
        }
    }
    
    
    //Get data from server.
    func getDataFromServer(url:String) {
        Alamofire.request(url).responseJSON { (dataResponse) in
            self.activityIndicator.stopAnimating()
            if dataResponse.result.isSuccess {
                do {
                    self.weatherDetailModel = try JSONDecoder().decode(WeatherDetailModel.self, from: dataResponse.data!)
                    self.tableViewWeatherDetail.reloadData()
                } catch {
                    //print(error.localizedDescription)
                    self.navigationController?.popViewController(animated: true)
                    self.listViewDetailDelegate.createAlert(message: error.localizedDescription, title: "Warning")
                }
            } else {
                self.listViewDetailDelegate.createAlert(message: "Request isn't successful", title: "Warning")
            }
        }
    }
    
    
}
