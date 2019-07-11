//
//  WebSocketServer.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

public struct WebSocketServer {
  public let scheme: Scheme
  public let host: String
  public let port: Int?
  
  public init(scheme: Scheme = .wss,
       host: String,
       port: Int? = nil) {
    self.scheme = scheme
    self.host = host
    self.port = port
  }
  
  public enum Scheme: String {
    case ws
    case wss
  }
}
