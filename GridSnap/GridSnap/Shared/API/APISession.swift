//
//  ImageGridGallerySwiftApp.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//
import Foundation
import Combine
import UIKit
struct APISession: APIService {
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T: Decodable {
        if let data = builder.urlRequest.httpBody  {
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        let request = builder.urlRequest
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unexpectedResponse }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    return Fail(error: APIError.unexpectedResponse)
                        .eraseToAnyPublisher()
                }
                if HTTPCodes.success.contains(statusCode) {
                    if let response = String(data: data, encoding: .utf8) {
                        print("API URL Response", response)
                    }
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] {
                            print("API URL Error", builder.urlRequest, json)
                            for key in json.keys {
                                if key == "message", let error = json[key] as? String {
                                    return Fail(error: APIError.compuslsionError(error, statusCode))
                                        .eraseToAnyPublisher()
                                } else if let errors = json[key] as? [[String: Any]] {
                                    for error in errors {
                                        for key in error.keys {
                                            if key == "code", let code = error[key] as? Int {
                                                return Fail(error: APIError.httpError(code))
                                                    .eraseToAnyPublisher()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    return Fail(error: APIError.httpError(statusCode))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
