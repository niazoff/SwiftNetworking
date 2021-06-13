//
//  HTTPClient.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

/// Returned upon successfully or unsuccessfully completing an HTTP request.
public typealias HTTPResult = Result<HTTPResponse, Error>

/// An HTTP client that can send requests to a server.
public protocol HTTPClient {
  /// Sends a `URLRequest` to load from the server.
  /// - Returns: A `Task` that encapsulates the loading task.
  @discardableResult
  func send(_ request: URLRequest, completionHandler: @escaping (HTTPResult) -> Void) -> Task
}

public extension HTTPClient {
  /// Sends a `URL` request to load from the server.
  /// - Returns: A `Task` that encapsulates the loading task.
  @discardableResult
  func send(_ url: URL, completionHandler: @escaping (HTTPResult) -> Void) -> Task {
    self.send(URLRequest(url: url), completionHandler: completionHandler)
  }
}

public extension HTTPClient {
  @available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
  func response(from request: URLRequest) async throws -> HTTPResponse {
    try await withCheckedThrowingContinuation { continuation in
      send(request) { result in
        switch result {
          case .success(let response): continuation.resume(returning: response)
          case .failure(let error): continuation.resume(throwing: error)
        }
      }
    }
  }
  
  @available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
  func response(from url: URL) async throws -> HTTPResponse {
    try await response(from: URLRequest(url: url))
  }
}

#if canImport(Combine)
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension HTTPClient {
  func taskPublisher(for request: URLRequest) -> HTTPTaskPublisher {
    HTTPTaskPublisher(client: self, request: request)
  }
  
  func taskPublisher(for url: URL) -> HTTPTaskPublisher {
    self.taskPublisher(for: URLRequest(url: url))
  }
}
#endif
