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

let CURRENT_WEATHER_URL = "\(base_URL)\(latitude)40.7128\(longitude)74.0059\(app_ID)\(api_Key)"

