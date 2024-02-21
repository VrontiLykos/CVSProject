//
//  SearchView.swift
//  CVSProject
//
//  Created by Ethan Burns on 2/21/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            searchView()
                .searchable(text: $searchText,
                            placement: .automatic,
                            prompt: "Search")
                .onChange(of: searchText, initial: true) { searchText, newVlaue in
                    viewModel.searchTextPublisher.send(newVlaue)
                }
                .navigationTitle("Home")
        }
    }
    
    @ViewBuilder
    private func searchView() -> some View {
        switch viewModel.photoSearchViewStates {
        case .loading(imagesList: let imagesList):
           SearchResultView(viewModel:viewModel, imagesList: imagesList)
        case .error(message: let message):
            Text(message)
                .padding()
        }
    }
}

#Preview {
    SearchView()
}


