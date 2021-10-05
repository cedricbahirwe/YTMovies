//
//  MoviesManager.swift
//  YTMovides
//
//  Created by Cédric Bahirwe on 05/10/2021.
//

import Foundation

class MoviesManager: ObservableObject {
    @Published
    private(set) var movies: [Movie] = []
    
    
    
    // Returns a max of 50 movies
    public func getAllMovies() {
        let url = "https://yts.mx/api/v2/list_movies.json"
        GetRequest<MoviesResponse>(url)
            .get { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.movies = response.data.movies
                    }
                case .failure(let error):
                    print(error.message)
                }
            }
            
    }
}
