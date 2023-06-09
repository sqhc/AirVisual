//
//  AutoCompletesViewModel.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/8/23.
//

import Foundation
import Combine

class AutoCompletesViewModel: ObservableObject{
    let query: String
    let lang: String
    let timezone: String
    let index: String
    let pressure: String
    let distance: String
    let temperature: String
    
    var autocompleteString = "https://airvisual1.p.rapidapi.com/v2/auto-complete?q="
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "airvisual1.p.rapidapi.com"
    ]
    
    @Published var autocompletes: AutoCompleteContainer?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(query: String, lang: String = "", timezone: String = "", index: String = "", pressure: String = "", distance: String = "", temperature: String = ""){
        self.query = query
        self.lang = lang
        self.timezone = timezone
        self.index = index
        self.pressure = pressure
        self.distance = distance
        self.temperature = temperature
    }
    
    func formSearchString(){
        autocompleteString += query
        
        if lang != ""{
            autocompleteString += "&x-user-lang=\(lang)"
        }
        
        if timezone != ""{
            autocompleteString += "&x-user-timezone=\(timezone)"
        }
        
        if index != ""{
            autocompleteString += "&x-aqi-index=\(index)"
        }
        
        if pressure != ""{
            autocompleteString += "&x-units-pressure=\(pressure)"
        }
        
        if distance != ""{
            autocompleteString += "&x-units-distance=\(distance)"
        }
        
        if temperature != ""{
            autocompleteString += "&x-units-temperature=\(temperature)"
        }
    }
    
    func fetchResults(){
        formSearchString()
        
        guard let url = URL(string: autocompleteString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> AutoCompleteContainer in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
//                guard let autocompletes = try? decoder.decode(AutoCompleteContainer.self, from: result.data) else{
//                    throw LoadError.failedToDecode
//                }
//                return autocompletes
                var autocompletes : AutoCompleteContainer!
                do{
                    autocompletes = try decoder.decode(AutoCompleteContainer.self, from: result.data)
                }catch{
                    print(error)
                    throw LoadError.custom(error: error)
                }
                return autocompletes
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] autocompletes in
                self?.autocompletes = autocompletes
            }
            .store(in: &bag)
    }
}
extension AutoCompletesViewModel{
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
