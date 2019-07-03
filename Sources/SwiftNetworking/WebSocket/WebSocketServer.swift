//
//  WebSocketServer.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

struct WebSocketServer {
  let scheme: Scheme
  let host: String
  let port: Int?
  
  init(scheme: Scheme = .wss,
       host: String,
       port: Int? = nil) {
    self.scheme = scheme
    self.host = host
    self.port = port
  }
  
  enum Scheme: String {
    case ws
    case wss
  }
}
