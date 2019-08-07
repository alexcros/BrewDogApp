//
//  Endpoint.swift
//  BrewDogApp
//
//  Created by Alexandre on 07/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

enum RequestType: String {
    case get
}

enum ApiEndpoint {
    case getBeers
    case food(name: String)
}

extension ApiEndpoint {
    func request<T: Encodable>(with baseURL: URL, andBody body: T) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        guard let data = try? JSONEncoder().encode(body) else { return request }
        request.httpBody = data
        
        return request
    }
    
    func request(with baseURL: URL, adding parameters: [String: String] = [:]) -> URLRequest {
        let url = buildUrl(with: baseURL, adding: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        print(request.url!)
        
        return request
    }
    
    func buildUrl(with baseURL: URL, adding parameters: [String: String] = [:]) -> URL {
        let url = baseURL.appendingPathComponent(path)
        
        var newParameters = self.parameters
        parameters.forEach { newParameters.updateValue($1, forKey: $0) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = newParameters.map(URLQueryItem.init)
        
        var request = URLRequest(url: components.url!)
        return request.url!
    }
}

extension ApiEndpoint {
    var method: RequestType {
        switch self {
        case .getBeers, .food:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getBeers, .food:
            return "/beers"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .food(let name):
            return ["food": String(name)]
        default:
            return [:]
        }
    }
}
