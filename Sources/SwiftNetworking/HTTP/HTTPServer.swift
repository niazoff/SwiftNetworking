//
//  HTTPServer.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

/// An HTTP server that accepts requests.
///
/// An example of an HTTP server is `https://www.apple.com:443`
/// where the scheme is `https`, the host is `apple.com` and the port is `443`.
/// Do not include any URL paths in `host` like `/iphone`.
public struct HTTPServer {
  public let scheme: Scheme
  public let host: String
  public let port: Int?
  
  public init(scheme: Scheme = .https,
       host: String,
       port: Int? = nil) {
    self.scheme = scheme
    self.host = host
    self.port = port
  }
  
  public enum Scheme: String {
    case http
    case https
  }
}
