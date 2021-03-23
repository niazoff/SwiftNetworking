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
        endpoint: HTTPEndpoint,
        queryItems: [URLQueryItem]? = nil) {
    var urlComponents = URLComponents()
    urlComponents.scheme = server.scheme.rawValue
    urlComponents.host = server.host
    urlComponents.port = server.port
    urlComponents.path = endpoint.endpoint.1
    urlComponents.queryItems = queryItems
    guard let url = urlComponents.url else { return nil }
    self.init(url: url)
    self.safeHTTPMethod = endpoint.endpoint.0
  }
  
  init?(server: HTTPServer,
        endpoint: HTTPEndpoint,
        queryItems: [String: String]? = nil) {
    self.init(server: server, endpoint: endpoint, queryItems: queryItems?.map(URLQueryItem.init))
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
