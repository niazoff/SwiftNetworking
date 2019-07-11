//
//  HTTPMethod.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

/// An HTTP request method.
///
/// Every HTTP request requires a method.
/// Most of the time requests simply use the `GET` method as in `GET https://www.apple.com/`.
public enum HTTPMethod: String {
  case GET, POST, PUT, PATCH, DELETE
}
