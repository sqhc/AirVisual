//
//  CityMeasurementView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/11/23.
//

import SwiftUI

struct CityMeasurementView: View {
    @ObservedObject var vm: CityMeasurementViewModel
    
    var body: some View {
        ZStack{
            if let measurements = vm.measurements?.data{
                VStack{
                    if let hourlys = measurements.hourlyMeasurements{
                        Section {
                            List(hourlys, id:\.ts){ hourly in
                                CityHourlyMeasurementsItem(hourlyMeasurements: hourly)
                            }
                            .frame(width: 400, height: 200)
                        } header: {
                            Text("Hourly measurements")
                        }
                    }
                    
                    if let dailys = measurements.dailyMeasurements{
                        Section {
                            List(dailys, id:\.ts){ daily in
                                CityHourlyMeasurementsItem(hourlyMeasurements: daily)
                            }
                            .frame(width: 400, height: 200)
                        } header: {
                            Text("Daily measurements")
                        }
                    }
                }
                .navigationTitle("City measurements")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchMeasurements)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CityHourlyMeasurementsItem: View{
    var hourlyMeasurements: CityHourlyMeasurement
    var body: some View{
        VStack{
            Text(hourlyMeasurements.ts ?? "")
            if let measurements = hourlyMeasurements.measurements{
                Section {
                    List(measurements, id:\.measure){ measurement in
                        Text("Value: \(measurement.value ?? 0.0)")
                        Text("Measure: \(measurement.measure ?? "")")
                        Text("Color: \(measurement.color ?? "")")
                        Text("Label: \(measurement.label ?? "")")
                    }
                    .listStyle(.plain)
                    .frame(width: 300, height: 100)
                } header: {
                    Text("Measurements")
                }
            }
        }
    }
}

struct CityMeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        CityMeasurementView(vm: CityMeasurementViewModel(id: ""))
    }
}
