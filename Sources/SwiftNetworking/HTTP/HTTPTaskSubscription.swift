//
//  HTTPTaskSubscription.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

public class HTTPTaskSubscription: Subscription {
  public let task: AsyncTask
  
  public init(task: AsyncTask) {
    self.task = task
  }
  
  public func request(_ demand: Subscribers.Demand) {}
  
  public func cancel() { task.cancel() }
}
