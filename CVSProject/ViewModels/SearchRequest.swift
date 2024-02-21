//
//  SearchRequest.swift
//  CVSProject
//
//  Created by Ethan Burns on 2/21/24.
//

import Foundation

struct SearchRequest: Requestable {
    var path: String
    var params: [String : String]
    init(path: String, params: [String : String]) {
        self.path = path
        self.params = params
    }
}
