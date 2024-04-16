//
//  ImageGridGallerySwiftApp.swift
//  ImageGridGallerySwift
//
//  Created by Vivek Patel on 16/04/24.
//
import Foundation
import SwiftUI
enum APIError: Error {
    case invalidURL
    case decodingError
    case httpError(HTTPCode)
    case unexpectedResponse
    case compuslsionError(String, HTTPCode)
}
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpError(code):
            let description = code.description
            if Int(description) == nil {
                return description
            }
            return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .decodingError: return "Response could not be decoded because its not in correct format"
        case let .compuslsionError(error, _): return error

        }
    }
    var statusCode: Int {
        switch self {
        case .invalidURL: return 101
        case let .httpError(code):
            return code
        case .unexpectedResponse: return 500
        case .decodingError: return 101
        case let .compuslsionError(_, code): return code
        }
    }
}
typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>
extension HTTPCodes {
    static let success = 200 ..< 300
}
