//
//  HTTPEndpoint.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

/// Conform to this protocol to specify an HTTP endpoint consisting of a method and a path to request from the server.
/// An example of an HTTP endpoint is `GET /iphone`.
public protocol HTTPEndpoint {
  var endpoint: (HTTPMethod, URLPath) { get }
}
