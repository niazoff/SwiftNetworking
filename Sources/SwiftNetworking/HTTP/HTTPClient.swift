//
//  HTTPClient.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

/// Returned upon successfully or unsuccessfully completing an HTTP request.
public typealias HTTPResult = Result<HTTPResponse, Error>

/// An HTTP client that can send requests to a server.
public protocol HTTPClient {
  /// Sends a `URLRequest` to load from the server.
  /// - Returns: An `AsyncTask` that encapsulates the loading task.
  @discardableResult
  func send(_ request: URLRequest, completionHandler: @escaping (HTTPResult) -> Void) -> AsyncTask
}

public extension HTTPClient {
  /// Sends a `URL` request to load from the server.
  /// - Returns: An `Task` that encapsulates the loading task.
  @discardableResult
  func send(_ url: URL, completionHandler: @escaping (HTTPResult) -> Void) -> AsyncTask {
    self.send(URLRequest(url: url), completionHandler: completionHandler)
  }
}

public extension HTTPClient {
  func response(from request: URLRequest) async throws -> HTTPResponse {
    let taskActor = TaskActor()
    return try await withTaskCancellationHandler {
      try await withCheckedThrowingContinuation { continuation in
        Task {
          await taskActor.set(send(request) { result in
            switch result {
              case .success(let response): continuation.resume(returning: response)
              case .failure(let error): continuation.resume(throwing: error)
            }
          })
        }
      }
    } onCancel: { Task { await taskActor.cancel() } }
  }
  
  func response(from url: URL) async throws -> HTTPResponse {
    try await response(from: URLRequest(url: url))
  }
}

private actor TaskActor {
  private var task: AsyncTask?
  
  func set(_ task: AsyncTask) { self.task = task }
  func cancel() { task?.cancel() }
}

public extension HTTPClient {
  func taskPublisher(for request: URLRequest) -> HTTPTaskPublisher {
    HTTPTaskPublisher(client: self, request: request)
  }
  
  func taskPublisher(for url: URL) -> HTTPTaskPublisher {
    self.taskPublisher(for: URLRequest(url: url))
  }
}
