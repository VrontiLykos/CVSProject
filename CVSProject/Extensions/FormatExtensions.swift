//
//  FormatExtensions.swift
//  CVSProject
//
//  Created by Ethan Burns on 2/21/24.
//

import Foundation

extension String {
    func extractImageWidthAndHeight() -> (width: Int, height: Int) {
        let regex = try! NSRegularExpression(pattern: "<img[^>]*width=\"(\\d+)\"[^>]*height=\"(\\d+)\"[^>]*>", options: .caseInsensitive)

        let match = regex.firstMatch(in: self, options: [], range: NSRange(startIndex..., in: self))

        if let match = match {
            let widthRange = match.range(at: 1)
            let heightRange = match.range(at: 2)

            let widthString = String(self[Range(widthRange, in: self)!])
            let heightString = String(self[Range(heightRange, in: self)!])

            let width = Int(widthString) ?? 0
            let height = Int(heightString) ?? 0

            return (width, height)
        } else {
            return (0, 0) // Return default values if not found
        }
    }
}

extension SearchViewStates: Equatable {
    public static func == (lhs: SearchViewStates, rhs: SearchViewStates) -> Bool {
        switch (lhs , rhs) {
        case (.loading(let lhsItems),   .loading(let rhsItems)):
            return lhsItems.count == rhsItems.count
        case (.error(let lhsError ), .error(message: let rhsError)):
            return lhsError == rhsError
        case (.error(message: _), .loading(imagesList:_)):
            return false
        case (.loading(imagesList:_), .error(message:_)):
            return false
        }
    }
}
