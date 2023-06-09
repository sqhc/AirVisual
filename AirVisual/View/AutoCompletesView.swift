//
//  AutoCompletesView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/8/23.
//

import SwiftUI

struct AutoCompletesView: View {
    @StateObject var vm: AutoCompletesViewModel
    @State var showed = false
    
    var body: some View {
        ZStack{
            if let autocompletes = vm.autocompletes?.data{
                LazyVStack{
                    if let cities = autocompletes.cities{
                        Section {
                            AutoCompleteCities(cities: cities)
                                .frame(width: 400, height: 100)
                        } header: {
                            Text("Cities")
                        }
                    }
                    
                    if let stations = autocompletes.stations{
                        Section {
                            AutoCompleteStations(stations: stations)
                                .frame(width: 400, height: 100)
                        } header: {
                            Text("Stations")
                        }
                    }
                    
                    if let contributors = autocompletes.contributors{
                        Section {
                            AutoCompleteContributors(contributors: contributors)
                                .frame(width: 400, height: 100)
                        } header: {
                            Text("Contributors")
                        }
                    }
                    
                    if let newses = autocompletes.news{
                        Section {
                            AutoCompleteNewses(newses: newses)
                                .frame(width: 400, height: 100)
                        } header: {
                            Text("News")
                        }
                    }
                    
                    if let resources = autocompletes.resources{
                        Section {
                            AutoCompleteResources(resources: resources)
                                .frame(width: 400, height: 100)
                        } header: {
                            Text("Resources")
                        }
                    }
                }
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else { return }
            showed.toggle()
            vm.fetchResults()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct AutoCompletesView_Previews: PreviewProvider {
    static var previews: some View {
        AutoCompletesView(vm: AutoCompletesViewModel(query: ""))
    }
}

struct AutoCompleteCities: View{
    var cities: [AutoCompleteCity]
    var body: some View{
        List(cities, id:\.id){ city in
            VStack(alignment: .leading){
                Text("City: \(city.city ?? "")")
                Text("State: \(city.state ?? "")")
                Text("Country: \(city.country ?? "")")
                Text("Latitude: \(city.location?.lat ?? 0.0) Longitude: \(city.location?.lon ?? 0.0)")
                Text("Measurement time: \(city.currentMeasurement?.ts ?? "")")
                Text("AQIUS: \(city.currentMeasurement?.aqius ?? 0) AQICN: \(city.currentMeasurement?.aqicn ?? 0)")
                NavigationLink("City information") {
                    CityInformationView(vm: CityInformationViewModel(id: city.id ?? ""))
                }
            }
        }
    }
}

struct AutoCompleteStations: View{
    var stations: [AutoCompleteStation]
    
    var body: some View{
        List(stations, id:\.id){ station in
            Text("Name: \(station.name ?? "")")
            Text("Country: \(station.country ?? "")")
            Text("State: \(station.state ?? "")")
            Text("City: \(station.city ?? "")")
            Text("Latitude: \(station.location?.lat ?? 0.0) Longitude: \(station.location?.lon ?? 0.0)")
            Text("Measured at: \(station.currentMeasurement?.ts ?? "")")
            Text("AQIUS: \(station.currentMeasurement?.aqius ?? 0) AQICN: \(station.currentMeasurement?.aqicn ?? 0)")
            if let pollutants = station.currentMeasurement?.pollutants{
                Section {
                    List(pollutants, id:\.pollutant){ pollutant in
                        Text("CONC: \(pollutant.conc ?? 0.0) AQIUS: \(pollutant.aqius ?? 0) AQICN: \(pollutant.aqicn ?? 0)")
                        Text("Pollutant: \(pollutant.pollutant ?? "")")
                    }
                    .frame(width: 400, height: 100)
                } header: {
                    Text("Pollutants")
                }
            }
        }
    }
}

struct AutoCompleteContributors: View{
    var contributors: [AutoCompleteContributor]
    
    var body: some View{
        List(contributors, id:\.id){ contributor in
            AsyncImage(url: URL(string: contributor.picture ?? ""))
            Text("Name: \(contributor.name ?? "")")
            Text("Subtype: \(contributor.subType ?? "")")
        }
    }
}

struct AutoCompleteNewses: View{
    var newses: [AutoCompleteNews]
    
    var body: some View{
        List(newses, id:\.date){ news in
            AsyncImage(url: URL(string: news.thumbnail ?? ""))
            Text("Title: \(news.title ?? "")")
            Text("Date: \(news.date ?? "")")
            Text("Author: \(news.author ?? "")")
            Text("Status: \(news.status ?? "")")
        }
    }
}

struct AutoCompleteResources: View{
    var resources: [AutoCompleteResource]
    
    var body: some View{
        List(resources, id:\.date){ resource in
            AsyncImage(url: URL(string: resource.thumbnail ?? ""))
            Text("Title: \(resource.title ?? "")")
            Text("Date: \(resource.date ?? "")")
            Text("Author: \(resource.author ?? "")")
            Text("Status: \(resource.status ?? "")")
        }
    }
}
