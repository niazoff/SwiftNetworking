//
//  HTTPTaskSubscription.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class HTTPTaskSubscription: Subscription {
  public let task: Task
  
  public init(task: Task) {
    self.task = task
  }
  
  public func request(_ demand: Subscribers.Demand) {}
  
  public func cancel() { task.cancel() }
}
