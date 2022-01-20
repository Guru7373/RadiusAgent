//
//  NetworkManager.swift
//  Radius Agent
//
//  Created by Karthi CK on 19/01/22.
//

import UIKit

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://my-json-server.typicode.com/iranjith4/ad-assignment/db"
    private let requestTimeOut = TimeInterval(30)
    
    func fetchFacilities(completionHandler: @escaping (Error?, FacilitiesModal?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: requestTimeOut)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHandler(error, nil)
                return
            }
            do {
                let facilitiesModal = try JSONDecoder().decode(FacilitiesModal.self, from: data)
                completionHandler(nil, facilitiesModal)
            } catch (let parseError) {
                completionHandler(parseError, nil)
            }
        }.resume()
    }
    
}
