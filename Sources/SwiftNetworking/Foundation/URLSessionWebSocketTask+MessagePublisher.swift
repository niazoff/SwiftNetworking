//
//  URLSessionWebSocketTask+MessagePublisher.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension URLSessionWebSocketTask {
  class MessagePublisher: Publisher {
    typealias Output = Message
    typealias Failure = Error
    
    private let task: URLSessionWebSocketTask
    private var currentValuesCount = 0
    
    init(task: URLSessionWebSocketTask) {
      self.task = task
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, S.Input == Output, S.Failure == Failure {
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
      switch subscriber.receive(newMessage) {
      case .max(let maxCount):
        guard currentValuesCount < maxCount else { break }; fallthrough
      case .unlimited: configureTask(for: subscriber)
      }
    }
  }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension URLSessionWebSocketTask {
  func messagePublisher() -> MessagePublisher { MessagePublisher(task: self) }
}