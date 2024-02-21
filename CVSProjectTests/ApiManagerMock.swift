//
//  ApiManagerMock.swift
//  CVSProjectTests
//
//  Created by Ethan Burns on 2/21/24.
//

import Foundation
@testable import CVSProject

class ApiManagerMock: ApiManagerContract {
    func restApi<T>(_ request: Requestable, type: T.Type) async throws -> T where T : Decodable {
        if let searchedKeyWord = request.params["tags"], searchedKeyWord.isEmpty {
            throw ApiCallError.apiError
        }
        return SearchResponse.imageResponseData as! T
    }
}

extension SearchResponse {
    static var imageResponseData: SearchResponse {
        SearchResponse(title:"", items: [Item(title: "", link: "", media: Media(m: ""), dateTaken: "", description: "", published: "", author: "", authorId: "", tags: "")])
    }
}
