//
//  MapListView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/13/23.
//

import SwiftUI

struct MapListView: View {
    @StateObject var vm: MapListViewModel
    
    var body: some View {
        ZStack{
            if let mapLists = vm.mapList?.data{
                List(mapLists, id:\.id){ mapList in
                    MapListItem(mapList: mapList)
                }
                .listStyle(.plain)
                .navigationTitle("Map list results")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchMapList()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct MapListView_Previews: PreviewProvider {
    static var previews: some View {
        MapListView(vm: MapListViewModel(NElon: "", SWlon: "", SWlat: "", NElat: ""))
    }
}

struct MapListItem: View{
    var mapList: MapInfo
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Name: \(mapList.name ?? "")")
            Text("Country: \(mapList.country ?? "")")
            Text("State: \(mapList.state ?? "")")
            Text("City: \(mapList.city ?? "")")
            Text("Latitude: \(mapList.location?.lat ?? 0.0) Longitude: \(mapList.location?.lon ?? 0.0)")
            Text("Type: \(mapList.type ?? "")")
            Text("Current measurement time: \(mapList.currentMeasurement?.ts ?? "")")
            Text("AQIUS: \(mapList.currentMeasurement?.aqius ?? 0) AQICN: \(mapList.currentMeasurement?.aqicn ?? 0)")
            if let pollutants = mapList.currentMeasurement?.pollutants{
                Section {
                    List(pollutants, id:\.pollutant){ po in
                        Text("Conc: \(po.conc ?? 0.0)")
                        Text("AQIUS: \(po.aqius ?? 0)")
                        Text("AQICN: \(po.aqicn ?? 0)")
                        Text("Pollutant: \(po.pollutant ?? "")")
                    }
                    .frame(width: 400, height: 100)
                } header: {
                    Text("Pollutants")
                }
            }
        }
    }
}
