//
//  CityInformationView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/9/23.
//

import SwiftUI

struct CityInformationView: View {
    @StateObject var vm: CityInformationViewModel
    
    var body: some View {
        ZStack{
            if let info = vm.cityInfo?.data{
                VStack{
                    Text("City name: \(info.city ?? "")")
                    Text("Country: \(info.country ?? "")")
                    Text("State: \(info.state ?? "")")
                    Text("Timezone: \(info.timezone ?? "")")
                    Text("Latitude: \(info.location?.lat ?? 0.0) Longitude: \(info.location?.lon ?? 0.0)")
                    HStack{
                        if let measure = info.currentMeasurement{
                            CityMeasurementItem(measurement: measure)
                        }
                        
                        if let weather = info.currentWeather{
                            CityCurrentWeatherItem(weather: weather)
                        }
                        
                        if let recommendations = info.recommendations{
                            CityRecommendations(recommendations: recommendations)
                        }
                    }
                }
                .navigationTitle("\(info.city ?? "") information")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchInfo()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CityInformationView_Previews: PreviewProvider {
    static var previews: some View {
        CityInformationView(vm: CityInformationViewModel(id: ""))
    }
}

struct CityMeasurementItem: View{
    var measurement: CityCurrentMeasurement
    var body: some View{
        VStack(alignment: .leading){
            Text("Measure time: \(measurement.ts ?? "")")
            Text("AQIUS: \(measurement.aqius ?? 0)")
            Text("MainUS: \(measurement.mainus ?? "")")
            Text("AQICN: \(measurement.aqicn ?? 0)")
            Text("MainCN: \(measurement.maincn ?? "")")
            if let pollutants = measurement.pollutants{
                Section {
                    List(pollutants, id:\.pollutant){ pollutant in
                        Text("Conc: \(pollutant.conc ?? 0.0)")
                        Text("AQIUS: \(pollutant.aqius ?? 0)")
                        Text("AQICN: \(pollutant.aqicn ?? 0)")
                        Text("Pollutant: \(pollutant.pollutant ?? "")")
                    }
                    .frame(width: 150, height: 100)
                } header: {
                    Text("Pollutants")
                }
            }
        }
    }
}

struct CityCurrentWeatherItem: View{
    var weather: CityCurrentWeather
    var body: some View{
        VStack(alignment: .leading){
            Text("Weather icon: \(weather.weatherIcon ?? "")")
            Text("Pressure: \(weather.pressure ?? 0)")
            Text("Humidity: \(weather.humidity ?? 0)%")
            Text("Wind speed: \(weather.windSpeed ?? 0.0)")
            Text("Wind direction: \(weather.windDirection ?? 0)")
            Text("Time: \(weather.ts ?? "")")
        }
    }
}

struct CityRecommendations: View{
    var recommendations: [CityRecommendation]
    var body: some View{
        List(recommendations, id:\.text){ recommendation in
            Text("Type: \(recommendation.type ?? "")")
            Text("Color: \(recommendation.color ?? "")")
            Text(recommendation.text ?? "")
        }
    }
}
