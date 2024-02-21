//
//  SearchViewModel.swift
//  CVSProject
//
//  Created by Ethan Burns on 2/21/24.
//

import Foundation
import Combine

enum SearchViewStates {
    case loading(imagesList: [Item])
    case error(message: String)
}

final class SearchViewModel: ObservableObject {
    
    @Published var photoSearchViewStates: SearchViewStates = .loading(imagesList: [])
    
    private let apiManager: ApiManagerContract
    let searchTextPublisher = PassthroughSubject<String, Never>()
    private var anyCancellable: AnyCancellable?
    init(apiManager: ApiManagerContract = ApiManager()) {
        self.apiManager = apiManager
        bindSearch()
    }
    
    private func bindSearch() {
        anyCancellable = searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { value in
                Task {
                    await self.search(value)
                }
            }
    }
}

extension SearchViewModel {
    
    @MainActor
    func search(_ searchWord: String) async {
        do {
            let searchRequest = SearchRequest(path: EndPoints.searchPath, params: ["format":"json", "nojsoncallback": "1", "tags":searchWord])
        
            let imageData = try await     apiManager.restApi(searchRequest, type: SearchResponse.self)
            photoSearchViewStates = .loading(imagesList: imageData.items)
        } catch let error {
            photoSearchViewStates = .error(message: error.localizedDescription)
        }
    }
}

