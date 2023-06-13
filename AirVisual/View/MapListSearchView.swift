//
//  MapListSearchView.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/13/23.
//

import SwiftUI

struct MapListSearchView: View {
    @State var NElon = ""
    @State var SWlon = ""
    @State var SWlat = ""
    @State var NElat = ""
    
    var body: some View {
        ZStack{
            VStack{
                TextField("Northeast longitude", text: $NElon)
                    .frame(width: 400, height: 30)
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                TextField("Southwest longitude", text: $SWlon)
                    .frame(width: 400, height: 30)
                    .background(Color.brown.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                TextField("Southwest latitude", text: $SWlat)
                    .frame(width: 400, height: 30)
                    .background(Color.red.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                TextField("Southwest latitude", text: $NElat)
                    .frame(width: 400, height: 30)
                    .background(Color.cyan.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                NavigationLink("Search with coordinates") {
                    MapListView(vm: MapListViewModel(NElon: NElon, SWlon: SWlon, SWlat: SWlat, NElat: NElat))
                }
            }
            .navigationTitle("Map list searching")
        }
    }
}

struct MapListSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapListSearchView()
    }
}
