//
//  CityMeasurementsDataModel.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/11/23.
//

import Foundation

struct CityMeasurementsContainer: Codable{
    let data: CityMeasurements?
}

struct CityMeasurements: Codable{
    let id: String?
    let hourlyMeasurements: [CityHourlyMeasurement]?
    let dailyMeasurements: [CityHourlyMeasurement]?
}

struct CityHourlyMeasurement: Codable{
    let ts: String?
    let measurements: [CityMeasurementComponent]?
}

struct CityMeasurementComponent: Codable{
    let value: Double?
    let measure: String?
    let color: String?
    let label: String?
}
