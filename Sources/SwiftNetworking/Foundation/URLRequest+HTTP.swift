//
//  URLRequest+HTTP.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

public extension URLRequest {
  init?(server: HTTPServer,
        endpoint: HTTPEndpoint) {
    var urlComponents = URLComponents()
    urlComponents.scheme = server.scheme.rawValue
    urlComponents.host = server.host
    urlComponents.port = server.port
    urlComponents.path = endpoint.endpoint.1
    guard let url = urlComponents.url else { return nil }
    self.init(url: url)
    self.safeHTTPMethod = endpoint.endpoint.0
  }
}

public extension URLRequest {
  var safeHTTPMethod: HTTPMethod? {
    get {
      guard let httpMethodString = self.httpMethod else { return nil }
      return HTTPMethod(rawValue: httpMethodString)
    } set { self.httpMethod = newValue?.rawValue }
  }
}
