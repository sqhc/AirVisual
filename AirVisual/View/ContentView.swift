//
//  ContentView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(colors: [Color.cyan, Color.blue], center: .topLeading, startRadius: 10, endRadius: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                VStack{
                    Text("How do you want to search for air pollution?")
                        .font(.largeTitle)
                    Spacer()
                    NavigationLink("Auto complete") {
                        AutoCompleteSearchAirView()
                    }
                    Divider()
                    NavigationLink("Map list search") {
                        MapListSearchView()
                    }
                    Spacer()
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
