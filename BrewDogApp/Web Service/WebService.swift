//
//  WebService.swift
//  BrewDogApp
//
//  Created by Alexandre on 07/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RxSwift
import RxCocoa

enum WebServiceError: Error {
    case badStatus(Int, Data)
    case api(Int, String)
}

private struct Status: Decodable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }
}

final class WebService {
    let baseUrl = URL(string: Constants.beerURL)!
    let session = URLSession.shared
    let decoder = JSONDecoder()
}

extension WebService: InitialService {
    
    func load<T>(_ type: T.Type, withQuery: String, from endpoint: ApiEndpoint) -> Observable<T> where T: Decodable {
        let decoder = self.decoder
        let request = ApiEndpoint.food(name: withQuery).request(with: baseUrl)
        return session.rx.data(request: request)
            .map { try decoder.decode(T.self, from: $0) }
            .catchError { error in
                guard let webServiceError = error as? WebServiceError else {
                    throw error
                }
                
                guard case let .badStatus(_, data) = webServiceError else {
                    throw error
                }
                
                guard let status = try? decoder.decode(Status.self, from: data) else {
                    throw error
                }
                
                throw WebServiceError.api(status.code, status.message)
        }
    }
    
    func getBeers(completion: @escaping ([Beer]?, Error?) -> Void) {
        let request = ApiEndpoint.getBeers.request(with: baseUrl)
        session.dataTask(with: request) { (data, _, error) in
            guard let data = data,
                let response = try? self.decoder.decode([Beer].self, from: data) else {
                    if let error = error {
                        completion(nil, error)
                    }
                    return
            }
            completion(response, nil)
            }.resume()
    }
}

private extension Reactive where Base: URLSession {
    func send(request: URLRequest) -> Observable<Data> {
        return Observable<Data>.create { observer in
            let task = self.base.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        fatalError("Unsupported protocol")
                    }
                    
                    if 200 ..< 300 ~= httpResponse.statusCode {
                        if let data = data {
                            observer.onNext(data)
                        }
                        observer.onCompleted()
                    }
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
