//
//  Model.swift
//  WeatherApp
//
//  Created by Diego Mojarro on 20/09/21.
//

import Foundation


struct Data: Codable{
    var coord: Coord
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
}

struct Coord: Codable{
    var lon: Float
    var lat: Float
}

struct Weather: Codable{
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable{
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Int
    var humidity: Int
}

struct Wind: Codable {
    var speed: Float
    var deg: Int
}

struct Clouds: Codable {
    var all: Int
}

struct Sys: Codable{
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}


