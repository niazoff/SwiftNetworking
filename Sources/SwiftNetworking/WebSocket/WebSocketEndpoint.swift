//
//  WebSocketEndpoint.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

public protocol WebSocketEndpoint {
  var endpoint: URLPath { get }
}
