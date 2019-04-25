//
//  Webservice.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

/// Enumeration of possible network errors
///
public enum NetworkError: Error, Equatable {
    /// - invalidData: Request was successful, but data couldn't be parsed because invalid data
    case invalidData(String)
    /// - emptyData: Request was successful, but no data was returned
    case emptyData
    /// - clientError: something went wrong in the client side; the associated value may contain a hint
    case clientError(String)
    /// - redirection: request was redirected
    case redirection
    /// - serverError: something went wrong in the server side
    case serverError
    /// - networkError: some network erro ocoured; the associated value may contain a hint
    case networkError(String)
    /// - unknowm: unknown error
    case unknowm
}

/// Class used to send network requests
public final class Webservice: NSObject {
    let urlSession: URLSession
    
    /// Initialization method
    ///
    /// If a instance of `URLSession` is not passed, it uses a default `URLSession` initialized with a
    /// `URLSessionConfiguration.default` configuration a `nil` operation queue
    /// - Parameter urlSession: Instance of URLSession class
    public init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default,
                                                    delegate: nil,
                                                    delegateQueue: nil)) {
        self.urlSession = urlSession
    }
    
    /// Method to send natwork requests in the form of a `Resource`
    ///
    /// - Parameters:
    ///   - resource: instance of `Resource` type, describing the network resource to be requested
    ///   - completion: a `(Result<T, NetworkError>) -> Void` code block, that can be used to treat the response of the
    ///   request
    /// - Returns: an instance of `URLSessionDataTask`, that can be used to cancel the request
    public func load<T>(_ resource: Resource<T>,
                        completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {
        let request = URLRequest(resource: resource)
        
        let task = urlSession.dataTask(with: request) { [weak self] data, urlResponse, error in
            guard let self = self else { return }
            let result: Result<T, NetworkError>
            if let response = urlResponse as? HTTPURLResponse, let status = response.status {
                switch status.responseType {
                case .success:
                    result = self.parse(data, for: resource, error: error)
                case .clientError:
                    let statusCode = response.statusCode
                    let message = "[\(statusCode)]: \(HTTPURLResponse.localizedString(forStatusCode: statusCode))"
                    result = Result(NetworkError.clientError(message))
                    fatalError("FIXME: [\(response) - URL: [\(response.url?.absoluteString ?? "invalid")]]")
                case .serverError:
                    result = Result(.serverError)
                default:
                    result = Result(.unknowm)
                }
            } else if let error = error {
                result = Result(.networkError(error.localizedDescription))
            } else {
                result = Result(.unknowm)
            }
            completion(result)
        }
        task.resume()
        return task
    }
    
    private func parse<T>(_ data: Data?,
                          for resource: Resource<T>,
                          error: Error?) -> Result<T, NetworkError> where T: Decodable {
        let result: Result<T, NetworkError>
        if let data = data {
            do {
                result = try Result(resource.parse(data))
            } catch {
                result = Result(NetworkError.invalidData(error.localizedDescription))
            }
        } else if let error = error {
            fatalError("FIXME: [\(error)]")
        } else {
            result = Result(NetworkError.emptyData)
        }
        return result
    }
}
