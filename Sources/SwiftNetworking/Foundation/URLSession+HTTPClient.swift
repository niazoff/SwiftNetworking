//
//  URLSession+HTTPClient.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

extension URLSession: HTTPClient {
  @discardableResult
  public func send(_ request: URLRequest, completionHandler: @escaping (HTTPResult) -> Void = { _ in }) -> Task {
    let task = self.dataTask(with: request) { data, response, error in
      self.dataTaskCompletionHandler(data: data, response: response, error: error, completionHandler: completionHandler)
    }
    task.resume()
    return task
  }
  
  private func dataTaskCompletionHandler(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (HTTPResult) -> Void) {
    if let error = error {
      completionHandler(.failure(error)); return
    } else if let response = response as? HTTPURLResponse, let data = data {
      // Ensure a valid HTTP status code or send the HTTP error.
      guard case 100..<300 = response.statusCode else {
        completionHandler(.failure(HTTPError(statusCode: response.statusCode, data: data))); return
      }
      completionHandler(.success(HTTPResponse(statusCode: response.statusCode, data: data)))
    }
  }
}
