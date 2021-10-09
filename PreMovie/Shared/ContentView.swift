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
        VStack {
            HStack {
                Button {
                    // Menu
                } label: {
                    Image(systemName: "line.horizontal.3.circle")
                        .imageScale(.large)
                }
                Spacer()
                Text("Action Movies")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                Spacer()
                Button {
                    // Menu
                } label: {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                }
                
            }
            .padding(10)
            
            Spacer()
        }
        .background(Color.primaryBackground.ignoresSafeArea())
        .foregroundColor(.white.opacity(0.9))
        .onAppear {
            moviesManager.getAllMovies()
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
                        self?.movies = response.data.movies
                    }
                case .failure(let error):
                    print(error.message)
                }
            }
            
    }
}

