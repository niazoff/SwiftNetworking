//
//  HTTPResponse.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

/// Returned upon successfully completing an HTTP request with the code and data.
struct HTTPResponse {
  let statusCode: Int
  let data: Data
}

extension HTTPResponse: Equatable {}
