//
//  URLRequest+WebSocket.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

extension URLRequest {
  init?(server: WebSocketServer,
        endpoint: WebSocketEndpoint) {
    var urlComponents = URLComponents()
    urlComponents.scheme = server.scheme.rawValue
    urlComponents.host = server.host
    urlComponents.port = server.port
    urlComponents.path = endpoint.endpoint
    guard let url = urlComponents.url else { return nil }
    self.init(url: url)
  }
}
