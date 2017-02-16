//
//  Constants.swift
//  RainOrShine
//
//  Created by New on 2/8/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import Foundation

let base_URL = "http://api.openweathermap.org/data/2.5/weather?"
let latitude = "lat="
let longitude = "&lon="
let app_ID = "&appid="
let api_Key = "cca67f826f6df3ae4af5e7d4cbe0b694"


//This tells us that we are done downloading from the JSON file.
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(base_URL)\(latitude)40.7143\(longitude)-74.006\(app_ID)\(api_Key)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=40.7143&lon=-74.006&cnt=10&mode=json&appid=cca67f826f6df3ae4af5e7d4cbe0b694"
