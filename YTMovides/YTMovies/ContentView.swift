//
//  ContentView.swift
//  YTMovides
//
//  Created by Cédric Bahirwe on 05/10/2021.
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
