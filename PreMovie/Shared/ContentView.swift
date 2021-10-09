//
//  ContentView.swift
//  Shared
//
//  Created by Cédric Bahirwe on 09/10/2021.
//

import SwiftUI


struct ContentView: View {
    @StateObject
    private var moviesManager = MoviesManager()
    
    @State
    private var selectedMovie: Movie? = nil
    var body: some View {
        NavigationView {
            List(moviesManager.movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title).bold()
                    Text(movie.descriptionFull)
                        .lineLimit(selectedMovie == movie ? nil : 4)
                }
                .padding()
                .onTapGesture {
                        if selectedMovie == movie {
                            selectedMovie = nil
                        } else {
                            selectedMovie = movie
                        }
                }
                
            }
            .navigationTitle("Movies")
            .onAppear {
                moviesManager.getAllMovies()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
                        print(response)
//                        self?.movies = response.data.movies
                    }
                case .failure(let error):
                    print(error.message)
                }
            }
            
    }
}

