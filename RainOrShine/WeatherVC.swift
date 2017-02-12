//
//  ViewController.swift
//  RainOrShine
//
//  Created by New on 2/2/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var currentTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!

    // This verariable creates an empty class of current weather were we can put functions in.
    var currentWeather = CurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
        }


    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }



    func updateMainUI() {
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)"
        currentTypeLbl.text = currentWeather.weatherType
        currentLocationLbl.text = currentWeather.citynName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }



}

