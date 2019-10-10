//
//  ViewController.swift
//  WeatherAppCovrChallenge
//
//  Created by Mehmet Can Seyhan on 2019-07-09.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit

class WeatherListVC: UIViewController, UITableViewDelegate, UITableViewDataSource,ListViewDetailDelegate, UISearchResultsUpdating {
   
   //IBOutlets
    @IBOutlet var weatherTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //Variables
    var weatherListModel:[WeatherListModel]?
    var filterTvListModel:[WeatherListModel]?
    
    var cityId:Int?
    var cityName:String?
    var isNewItemLoad:Bool = true
    
    //Constants
    let TO_DETAIL_SEGUE_IDENTIFIER:String = "fromWeatherListVCToDetailVC"
    let WEATHER_LIST_CELL_IDENTIFIER:String = "weatherListCellIdentifier"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //Mark: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setFirstValuesAndCallFuncs()
    }
    
    //Set first values and call functions
    func setFirstValuesAndCallFuncs() {
        getLocalJSONData()
        addSeacrhBar()
        self.title = "City List"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WEATHER_LIST_CELL_IDENTIFIER) as! WeatherListCell
        cell.weatherListModel = WeatherListModelView(weatherListModel: weatherListModel![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.weatherTableView.deselectRow(at: indexPath, animated: true)
        if let id = weatherListModel?[indexPath.row].id {
            self.cityId = id
            self.cityName = weatherListModel?[indexPath.row].name ?? ""
            performSegue(withIdentifier: TO_DETAIL_SEGUE_IDENTIFIER, sender: nil)
        } else {
            createAlert(message: "City id is empty", title: "Warning")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc:WeatherDetailVC = segue.destination as! WeatherDetailVC
        vc.cityId = self.cityId
        vc.cityName = self.cityName
        vc.listViewDetailDelegate = self
    }
    
    func createAlert(message: String, title: String) {
        Helper.dialogMessage(message: message, vc: self)
    }
    
    //Get local data from City List Json File and reload data to loading
    func getLocalJSONData() {
        guard let path = Bundle.main.path(forResource: "city.list", ofType: "json") else {
            self.activityIndicator.stopAnimating()
            return
        }
        let url = URL(fileURLWithPath: path)
        let data = try? Data(contentsOf: url)
        do {
            self.weatherListModel = try JSONDecoder().decode([WeatherListModel].self, from: data!)
            self.filterTvListModel = weatherListModel
            self.activityIndicator.stopAnimating()
            self.weatherTableView.reloadData()
        } catch {
            self.activityIndicator.stopAnimating()
            self.createAlert(message: error.localizedDescription, title: "Warning")
        }
    }
    
    // MARK: - UISearchResultsUpdating Delegate
       func updateSearchResults(for searchController: UISearchController) {
           // TODO
           guard let text = searchController.searchBar.text else { return }
           let searchText = text.lowercased()
           if !text.isEmpty && filterTvListModel != nil {
            self.weatherListModel = filterTvListModel!.filter({ ($0.name!.lowercased().contains(searchText)) })
           } else {
                self.weatherListModel = filterTvListModel
           }
           self.weatherTableView.reloadData()
           
       }
    
    
    // Setup the Search Controller
    func addSeacrhBar() {
       // navigationItem.searchController = searchController
        weatherTableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City..."
        definesPresentationContext = true
       /* searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.red*/
    }
}

