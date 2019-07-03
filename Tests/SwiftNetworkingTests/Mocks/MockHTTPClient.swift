//
//  MockHTTPClient.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
@testable import SwiftNetworking

struct MockHTTPClient: HTTPClient {
  let sendHandler: (URLRequest) -> (HTTPResult, Task)
  
  func send(_ request: URLRequest, completionHandler: @escaping (HTTPResult) -> Void) -> Task {
    let values = sendHandler(request)
    completionHandler(values.0)
    return values.1
  }
}
