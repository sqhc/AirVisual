//
//  CityInformationDataModel.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/9/23.
//

import Foundation

struct CityInformationContainer: Codable{
    let data: CityInformation?
}

struct CityInformation: Codable{
    let id: String?
    let name: String?
    let city: String?
    let state: String?
    let country: String?
    let location: CityLocation?
    let timezone: String?
    let currentMeasurement: CityCurrentMeasurement?
    let currentWeather: CityCurrentWeather?
    let recommendations: [CityRecommendation]?
}

struct CityCurrentMeasurement: Codable{
    let ts: String?
    let aqius: Int?
    let mainus: String?
    let aqicn: Int?
    let maincn: String?
    let pollutants: [CityPollutant]?
}

struct CityPollutant: Codable{
    let conc: Double?
    let aqius: Int?
    let aqicn: Int?
    let pollutant: String?
}

struct CityCurrentWeather: Codable{
    let ts: String?
    let temperature: Int?
    let pressure: Int?
    let humidity: Int?
    let windSpeed: Double?
    let windDirection: Int?
    let weatherIcon: String?
}

struct CityRecommendation: Codable{
    let type: String?
    let color: String?
    let text: String?
}
