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
class HTTPTaskSubscription: Subscription {
  let task: Task
  
  init(task: Task) {
    self.task = task
  }
  
  func request(_ demand: Subscribers.Demand) {}
  
  func cancel() { task.cancel() }
}
