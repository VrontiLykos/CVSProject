//
//  ApiManagerTests.swift
//  CVSProjectTests
//
//  Created by Ethan Burns on 2/21/24.
//

import XCTest
@testable import CVSProject

final class ApiManagerTests: XCTestCase {

    var apiManager: ApiManager!
    
    override func setUp() {
        apiManager = ApiManager()
    }

    override func tearDown() {
        apiManager = nil
    }
    
    func testInvlalidRequest() async {
        
        // when empty path and params
        let request = SearchRequest(path:"", params:[:])
        
        do {
          let _ = try await apiManager.restApi(request, type: SearchResponse.self)
        }catch {
            XCTAssertEqual(error as! ApiCallError, ApiCallError.invalidRequest)
        }
    }
}
