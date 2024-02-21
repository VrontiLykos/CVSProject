//
//  ApiCallError.swift
//  CVSProject
//
//  Created by Ethan Burns on 2/21/24.
//

import Foundation

enum ApiCallError:Error {
    case invalidRequest
    case apiError
    case dataNotFound
    case responseError
    case parsingError
    case invalidResponse
}
