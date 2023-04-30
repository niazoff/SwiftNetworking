//
//  MockTask.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
@testable import SwiftNetworking

struct MockTask: AsyncTask {
  func suspend() {}
  
  func resume() {}
  
  func cancel() {}
}
