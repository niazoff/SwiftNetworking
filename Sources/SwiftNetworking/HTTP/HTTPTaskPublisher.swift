//
//  HTTPTaskPublisher.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

#if canImport(Combine)
import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct HTTPTaskPublisher: Publisher {
  public typealias Output = HTTPResponse
  public typealias Failure = Error
  
  public let client: HTTPClient
  public let request: URLRequest
  
  public func receive<S>(subscriber: S) where S: Subscriber, S.Input == Output, S.Failure == Failure {
    subscriber.receive(subscription: HTTPTaskSubscription(task: client.send(request) { result in
      switch result {
      case .success(let response):
        switch subscriber.receive(response) { default: break }
        subscriber.receive(completion: .finished)
      case .failure(let error):
        subscriber.receive(completion: .failure(error))
      }
    }))
  }
}
#endif
