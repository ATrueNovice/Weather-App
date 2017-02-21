//
//  location.swift
//  RainOrShine
//
//  Created by New on 2/16/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import CoreLocation

class Location {


    static var sharedInstance = Location()
    private init() {}

    var latitude: Double!
    var longitude: Double!
    

}
