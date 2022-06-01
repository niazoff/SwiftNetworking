//
//  HTTPError.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

/// Returned upon failing an HTTP request with the failing code and data.
public struct HTTPError: Error {
  public let statusCode: Int
  public let data: Data
  
  public init(statusCode: Int,
              data: Data) {
    self.statusCode = statusCode
    self.data = data
  }
}
