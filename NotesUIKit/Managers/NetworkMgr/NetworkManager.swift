//
//  Alamofire.swift
//  Notes
//
//  Created by Amer Alyusuf on 07/12/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let baseURL = "http://worldtimeapi.org/api/ip"
    
    static func getRequest<T: Codable>(urlString: String) async throws -> T {
        do {
            let response = try await AF.request(urlString, interceptor: .connectionLostRetryPolicy(retryLimit: 4))
                .validate()
                .serializingDecodable(T.self)
                .value
            
            return response
        } catch {
            throw error
        }
    }
}
