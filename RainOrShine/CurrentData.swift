//
//  CurrentData.swift
//  RainOrShine
//
//  Created by New on 2/8/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {

    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!


    //JSON input 
    var citynName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }

    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"

        return _date
    }

    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }

    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }

    //This function tells our program that we are done downloading data as well as where to download from.
    func downloadWeatherDetails (completed: DownloadComplete) {

        //CURRENT_WEATHER_URL pulls from the constant files URL for the API
        //This starts the Get request to pull the data and tells the app what kind of data is coming in. JSON

        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            print(response)
        
    }
    completed()
}
}
