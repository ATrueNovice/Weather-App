//
//  WeatherCell.swift
//  RainOrShine
//
//  Created by New on 2/15/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    func configureCell(forecast: Forecast) {

    lowTemp.text = forecast.lowTemp
    highTemp.text = forecast.highTemp
    weatherType.text = forecast.weatherType
    dayLbl.text = forecast.date
    weatherIcon.image = UIImage(named: forecast.weatherType)

    }
        
    }


