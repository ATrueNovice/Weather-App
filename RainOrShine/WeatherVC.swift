//
//  ViewController.swift
//  RainOrShine
//
//  Created by New on 2/2/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
//Allows the app to find the device.
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {


    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var currentTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var viewBackground: UIView!

    //Location Manager keeps track of where we are and updates the GPS Coordinates.

    let locationmanager = CLLocationManager()
    var currentLocation: CLLocation! //This variable will be passed location coordinates.


    // This verariable creates an empty class of current weather were we can put functions in.
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    //Creates an array of the forecasts for the week
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //This class will receive and publish info.
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest //Gives us the best accuracy on a device
        locationmanager.requestWhenInUseAuthorization() //Asks to use your location.
        locationmanager.startMonitoringSignificantLocationChanges() //keeps track of significant location changes.

        tableView.delegate = self
        tableView.dataSource = self

        //Calls the Current Weather from CurrentData class and allows it to be accessed in the weather VC
        currentWeather = CurrentWeather()


    }
    //View Did Appear runs prior to the view did load. Before the view loads, we run the function asking for authorization. If we don't get the authorization, it starts off a loop that continually asks the user for the location.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    //Asks
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationmanager.location //Saves the location into the variable currentlocation
        Location.sharedInstance.latitude = currentLocation.coordinate.latitude // grabs the long
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude // grabs the lat



            //Puts the details from the Download Forecast Function into the current weather variables.
            currentWeather.downloadWeatherDetails {

                //Downloads the JSON data from the Forecast URL
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }

        } else {
            locationmanager.requestWhenInUseAuthorization() //Asks for your location and give allow or deny
            locationAuthStatus() //Asks again if we can be authorized. Once authorized it saves location to currentLocation.
        }
    }


    func downloadForecastData(completed: @escaping DownloadComplete) {
        //downloading forecast weather data for tableview

        //URL that calls the API details. Declares variable foreastURL and implements the URL from the Constants file.
        let forecastURL = URL(string: FORECAST_URL)!
        //Uses AlmoFire to pull the JSON file and interprets it in file.
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result

            //Breaks down the JSON file in to the dictionary. Each expandable tab is known as a dictionary. To access each file the app needs to parse the file.
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {

                    //For each instance in the list dictionary we open and append the forecast file.
                for obj in list {
                    let forecast = Forecast(weatherDict: obj)
                    self.forecasts.append(forecast) //Updates the list
                    print(obj)
                }
                    self.forecasts.remove(at:0)
                    self.tableView.reloadData()

            }


    }
            completed()
    }
    }
    //Tableview functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    //Pulls from WeatherCell VC to continually update the table.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }


    //Updates all UI interfaces in the View. Not the table.
    func updateMainUI() {
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)"
        currentTypeLbl.text = currentWeather.weatherType
        currentLocationLbl.text = currentWeather.citynName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }



}

