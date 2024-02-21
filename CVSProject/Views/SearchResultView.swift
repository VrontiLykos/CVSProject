//
//  SearchResultView.swift
//  CVSProject
//
//  Created by Ethan Burns on 2/21/24.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    @Namespace private var imageNamespace

    // Adjust the number of columns for landscape mode
    private var columns: [GridItem] {
        let numberOfColumns = sizeClass == .compact ? 2 : 4 // the right-side is the landscape
        return Array(repeating: .init(.flexible()), count: numberOfColumns)
    }
    
    let imagesList: [Item]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(imagesList) { imageData in
                    NavigationLink(destination: SearchItemDetailsScreen(cellData: imageData, namespace: imageNamespace)) {
                        SearchViewItem(cellData: imageData, namespace: imageNamespace)
                    }
                }
            }
        }
    }
}
