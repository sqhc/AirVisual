//
//  AutoCompleteDataModel.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/8/23.
//

import Foundation

struct AutoCompleteContainer: Codable{
    let data: AutoComplete?
}

struct AutoComplete: Codable{
    let cities: [AutoCompleteCity]?
    let stations: [AutoCompleteStation]?
    let contributors: [AutoCompleteContributor]?
    let news: [AutoCompleteNews]?
    let resources: [AutoCompleteResource]?
}

struct AutoCompleteCity: Codable{
    let id: String?
    let city: String?
    let state: String?
    let country: String?
    let location: CityLocation?
    let currentMeasurement: CityMeasurement?
    let type: String?
}

struct CityLocation: Codable{
    let lon: Double?
    let lat: Double?
}

struct CityMeasurement: Codable{
    let ts: String?
    let aqius: Int?
    let aqicn: Int?
    let isEstimated: Int?
}

struct AutoCompleteStation: Codable{
    let id: String?
    let name: String?
    let city: String?
    let state: String?
    let country: String?
    let location: CityLocation?
    let currentMeasurement: StationMeasurement?
    let type: String?
}

struct StationMeasurement: Codable{
    let ts: String?
    let aqius: Int?
    let aqicn: Int?
    let pollutants: [StationPollutant]?
}

struct StationPollutant: Codable{
    let conc: Double?
    let aqius: Int?
    let aqicn: Int?
    let pollutant: String?
}

struct AutoCompleteContributor: Codable{
    let id: String?
    let name: String?
    let type: String?
    let subType: String?
    let picture: String?
}

struct AutoCompleteNews: Codable{
    let author: String?
    let date: String?
    let status: String?
    let thumbnail: String?
    let title: String?
    let type: String?
    let url: String?
}

struct AutoCompleteResource: Codable{
    let author: String?
    let date: String?
    let status: String?
    let thumbnail: String?
    let title: String?
    let type: String?
    let url: String?
}
