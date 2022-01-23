//
//  HTTPClientTests.swift
//  SwiftNetworking
//
//  Created by Natanel Niazoff on 7/3/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import XCTest
@testable import SwiftNetworking
#if canImport(Combine)
import Combine
#endif

final class HTTPClientTests: XCTestCase {
  let testURL: URL = {
    guard let url = URL(string: "https://www.apple.com/") else { fatalError() }
    return url
  }()
  
  let testData: Data = {
    guard let data = "Hello World".data(using: .utf8) else { fatalError() }
    return data
  }()
  
  func testSend() {
    let testResponse = HTTPResponse(statusCode: 200, data: testData)
    let testClient = MockHTTPClient { _ in (.success(testResponse), MockTask()) }
    testClient.send(testURL) { result in
      switch result {
      case .success(let response): XCTAssertEqual(response, testResponse)
      case .failure(let error): XCTFail(error.localizedDescription)
      }
    }
  }
  
  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  func testAsyncSend() async throws {
    let testResponse = HTTPResponse(statusCode: 200, data: testData)
    let testClient = MockHTTPClient { _ in (.success(testResponse), MockTask()) }
    let response = try await testClient.response(from: testURL)
    XCTAssertEqual(response, testResponse)
  }
  
  #if canImport(Combine)
  @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  func testTaskPublisher() {
    let testResponse = HTTPResponse(statusCode: 200, data: testData)
    let testClient = MockHTTPClient { _ in (.success(testResponse), MockTask()) }
    _ = testClient.taskPublisher(for: testURL)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error): XCTFail(error.localizedDescription)
        case .finished: break
        }
      }) { XCTAssertEqual($0, testResponse) }
  }
  #endif
}
