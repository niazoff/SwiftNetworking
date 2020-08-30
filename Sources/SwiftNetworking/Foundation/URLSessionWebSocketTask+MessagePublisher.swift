//
//  URLSessionWebSocketTask+MessagePublisher.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

#if canImport(Combine)
import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSessionWebSocketTask {
  class MessagePublisher: Publisher {
    public typealias Output = Message
    public typealias Failure = Error
    
    private let task: URLSessionWebSocketTask
    private var currentValuesCount = 0
    
    public init(task: URLSessionWebSocketTask) {
      self.task = task
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, S.Input == Output, S.Failure == Failure {
      configureTask(for: subscriber)
    }
    
    private func configureTask<S>(for subscriber: S) where S: Subscriber, S.Input == Output, S.Failure == Failure {
      task.receive { [weak self] result in
        switch result {
        case .success(let message):
          self?.currentValuesCount += 1
          self?.handle(message, for: subscriber)
        case .failure(let error):
          subscriber.receive(completion: .failure(error))
        }
      }
    }
    
    private func handle<S>(_ newMessage: Message, for subscriber: S) where S: Subscriber, S.Input == Output, S.Failure == Failure {
      let demand = subscriber.receive(newMessage)
      if let maxCount = demand.max {
        guard currentValuesCount < maxCount else { return }
      }
      configureTask(for: subscriber)
    }
  }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension URLSessionWebSocketTask {
  public func messagePublisher() -> MessagePublisher { MessagePublisher(task: self) }
}
#endif
