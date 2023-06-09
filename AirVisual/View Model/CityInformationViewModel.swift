//
//  CityInformationViewModel.swift
//  AirVisual
//
//  Created by 沈清昊 on 6/9/23.
//

import Foundation
import Combine

class CityInformationViewModel: ObservableObject{
    let id: String
    
    var searchInformationString = "https://airvisual1.p.rapidapi.com/cities/v2/get-information?id="
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "airvisual1.p.rapidapi.com"
    ]
    
    @Published var cityInfo: CityInformationContainer?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(id: String){
        self.id = id
    }
    
    func fetchInfo(){
        searchInformationString += id
        
        guard let url = URL(string: searchInformationString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> CityInformationContainer in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let info = try? decoder.decode(CityInformationContainer.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return info
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] info in
                self?.cityInfo = info
            }
            .store(in: &bag)
    }
}
extension CityInformationViewModel{
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
