//
//  AutoCompleteSearchAirView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/8/23.
//

import SwiftUI

struct AutoCompleteSearchAirView: View {
    @State var query = ""
    @State var lang = ""
    @State var timezone = ""
    @State var index = ""
    @State var pressure = ""
    @State var distance = ""
    @State var temperature = ""
    
    var body: some View {
        ZStack{
            VStack{
                searchArea(query: $query, lang: $lang, timezone: $timezone, index: $index, pressure: $pressure, distance: $distance, temperature: $temperature)
//                NavigationLink("Autocomplete search") {
//                    AutoCompletesView(vm: AutoCompletesViewModel(query: query, lang: lang, timezone: timezone, index: index, pressure: pressure, distance: distance, temperature: temperature))
//                }
            }
            .navigationTitle("Auto complete search")
        }
    }
}

struct AutoCompleteSearchAirView_Previews: PreviewProvider {
    static var previews: some View {
        AutoCompleteSearchAirView()
    }
}

struct searchArea: View{
    @Binding var query: String
    @Binding var lang: String
    @Binding var timezone: String
    @Binding var index: String
    @Binding var pressure: String
    @Binding var distance: String
    @Binding var temperature: String
       
    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            TextField("Query", text: $query)
                .frame(width: 400, height: 30)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .padding(10)
            
            TextField("Language", text: $lang)
                .frame(width: 400, height: 30)
                .background(Color.blue.opacity(0.3).cornerRadius(20))
                .padding(10)
            
            TextField("Timezone", text: $timezone)
                .frame(width: 400, height: 30)
                .background(Color.red.opacity(0.3).cornerRadius(20))
                .padding(10)
            
            HStack(spacing: 5){
                VStack(spacing: 10) {
                    Text("Type of index: \(index)")
                }
                .foregroundColor(.white)
                .padding(10)
                .background(Color.brown.cornerRadius(20))
                .contextMenu{
                    Button {
                        index = "us"
                    } label: {
                        Text("US")
                    }

                    Button {
                        index = "cn"
                    } label: {
                        Text("CN")
                    }
                }
                
                VStack(spacing: 10) {
                    Text("Type of pressure: \(pressure)")
                }
                .foregroundColor(.white)
                .padding(10)
                .background(Color.black.cornerRadius(20))
                .contextMenu{
                    Button {
                        pressure = "hg"
                    } label: {
                        Text("Hg")
                    }

                    Button {
                        pressure = "mbar"
                    } label: {
                        Text("Mbar")
                    }
                }
                
                VStack(spacing: 10){
                    Text("Type of distance: \(distance)")
                }
                .foregroundColor(.white)
                .padding(10)
                .background(Color.purple.cornerRadius(20))
                .contextMenu{
                    Button {
                        distance = "miles"
                    } label: {
                        Text("Miles")
                    }

                    Button {
                        distance = "kilometer"
                    } label: {
                        Text("Kilometer")
                    }
                }
                
                VStack(spacing: 10){
                    Text("Type of temperature: \(temperature)")
                }
                .foregroundColor(.white)
                .padding(10)
                .background(Color.orange.cornerRadius(20))
                .contextMenu{
                    Button {
                        temperature = "fahrenheit"
                    } label: {
                        Text("Fahrenheit")
                    }

                    Button {
                        temperature = "celsius"
                    } label: {
                        Text("Celsius")
                    }
                }
            }
            
            NavigationLink("Autocomplete search") {
                AutoCompletesView(vm: AutoCompletesViewModel(query: query, lang: lang, timezone: timezone, index: index, pressure: pressure, distance: distance, temperature: temperature))
            }
        }
    }
}
