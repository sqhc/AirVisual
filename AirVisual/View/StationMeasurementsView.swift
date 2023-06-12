//
//  StationMeasurementsView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/12/23.
//

import SwiftUI

struct StationMeasurementsView: View {
    @ObservedObject var vm: StationMeasurementsViewModel
    
    var body: some View {
        ZStack{
            if let measurements = vm.measurements?.data{
                VStack{
                    if let hourlys = measurements.hourlyMeasurements{
                        Section {
                            List(hourlys, id:\.ts){ hourly in
                                StationHourlyMeasurementsItem(hourlyMeasurements: hourly)
                            }
                            .frame(width: 400, height: 200)
                        } header: {
                            Text("Hourly measurements")
                        }
                    }
                    
                    if let dailys = measurements.dailyMeasurements{
                        Section {
                            List(dailys, id:\.ts){ daily in
                                StationHourlyMeasurementsItem(hourlyMeasurements: daily)
                            }
                            .frame(width: 400, height: 200)
                        } header: {
                            Text("Daily measurements")
                        }
                    }
                }
                .navigationTitle("Station measurements")
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

struct StationMeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        StationMeasurementsView(vm: StationMeasurementsViewModel(id: ""))
    }
}

struct StationHourlyMeasurementsItem: View{
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
