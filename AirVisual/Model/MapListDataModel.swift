//
//  MapListDataModel.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/13/23.
//

import Foundation

struct MapList: Codable{
    let data: [MapInfo]?
}
struct MapInfo: Codable{
    let id: String?
    let name: String?
    let city: String?
    let state: String?
    let country: String?
    let location: CityLocation?
    let currentMeasurement: StationMeasurement?
    let type: String?
}
