//
//  MapListViewModel.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/13/23.
//

import Foundation
import Combine

class MapListViewModel: ObservableObject{
    let NElon: String
    let SWlon: String
    let SWlat: String
    let NElat: String
    
    var searchMapListString = "https://airvisual1.p.rapidapi.com/places/v2/list-by-map?"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "airvisual1.p.rapidapi.com"
    ]
    
    @Published var mapList: MapList?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(NElon: String, SWlon: String, SWlat: String, NElat: String){
        self.NElon = NElon
        self.SWlon = SWlon
        self.SWlat = SWlat
        self.NElat = NElat
    }
    
    func fetchMapList(){
        searchMapListString += "NElon=\(NElon)&SWlon=\(SWlon)&SWlat=\(SWlat)&NElat=\(NElat)"
        
        guard let url = URL(string: searchMapListString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> MapList in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let mapList = try? decoder.decode(MapList.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return mapList
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] mapList in
                self?.mapList = mapList
            }
            .store(in: &bag)
    }
}
extension MapListViewModel{
    enum LoadError: LocalizedError{
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode
        case failedToUnwrapOptional
        
        var errorDescription: String?{
            switch self {
            case .custom(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Unable to decode data."
            case .invalidStatusCode:
                return "The GET request failed due to invalid status code."
            case .failedToUnwrapOptional:
                return "Failed to unwrap optional value."
            }
        }
    }
}
