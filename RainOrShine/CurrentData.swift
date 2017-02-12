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
    var _currentTemp: Double!


    //JSON input 
    var citynName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }

    //We pull the date from the app it self. This code specifies that.
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
    func downloadWeatherDetails (completed: @escaping DownloadComplete) {

        //CURRENT_WEATHER_URL pulls from the constant files URL for the API
        //This starts the Get request to pull the data and tells the app what kind of data is coming in. JSON

        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result

            //Creates dictionary for JSON files
            if let dict = result.value as? Dictionary<String, AnyObject> {

                //Pull info by individual keys in our JSON file
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized //Makes sure the first letter is capitlized

                    print(self._cityName)
                }
                //Since the main detail for weather is in the dictionary array, we have to use more code to pull from the dictionary and not within the name value. 
                //Essentially opening the data twice. Once for the dicitonary name and then for the key.
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        print(self.weatherType)
                    }
            }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {

                    if let currentTemperature = main["temp"] as? Double {

                        let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)

                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))

                        self._currentTemp = kelvinToFarenheit
                        print(self._currentTemp)

}


}
}
            completed()
}
}
}
