//
//  SearchViewModelTests.swift
//  CVSProjectTests
//
//  Created by Ethan Burns on 2/21/24.
//

import XCTest

final class SearchViewModelTests: XCTestCase {

    var viewModel: SearchViewModel!
    let apiManager: ApiManagerContract = ApiManagerMock()
    
    override func setUp() {
        viewModel = SearchViewModel(apiManager: apiManager)
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_search_success_validUrl() async {
        
        // Given
        XCTAssertEqual(viewModel.photoSearchViewStates, .loading(imagesList: []))
        // When
        await viewModel.search("mockUrl")
        // Then
        XCTAssertEqual(viewModel.photoSearchViewStates, .loading(imagesList: SearchResponse.imageResponseData.items))
    }
    
    func test_search_success_invalidUrl() async {
        
        // Given
        XCTAssertEqual(viewModel.photoSearchViewStates, .loading(imagesList: []))
        // When
        await viewModel.search("")
        // Then
        XCTAssertEqual(viewModel.photoSearchViewStates, .error(message:ApiCallError.apiError.localizedDescription))
    }
}

