//
//  AsyncTask.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

/// Encapsulates a loading task.
public protocol AsyncTask {
  /// Temporarily suspends a task.
  func suspend()
  
  /// Resumes the task, if it is suspended.
  func resume()
  
  /// Cancels the task.
  func cancel()
}
