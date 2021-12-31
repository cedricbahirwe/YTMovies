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
    
    private let size = UIScreen.main.bounds.size
    
    @State
    private var selectedMovie: Movie? = nil
    
    @Namespace
    private var animation
    
    private var navigationBar: some View {
        HStack {
            leadingNavigationButton
            Spacer()
            if let movie = selectedMovie {
                navTitle(movie.title)
            } else {
                navTitle("Action Movies")
            }
            Spacer()
            searchButton
        }
    }
    
    var body: some View {
        VStack {
            navigationBar
                .padding(10)
            
            GeometryReader { geo in
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            //                    ForEach(0..<10) { i in
                            ForEach(moviesManager.movies.isEmpty ? [.exampleMovie] : moviesManager.movies) { movie in
                                
                                MoviePreview(of: movie, size: geo.size, animation: animation) { movie in
                                    withAnimation {
                                        selectedMovie = movie
                                    }
                                }
                            }
                        }
                    }
                    
                    if let selectedMovie = selectedMovie {
                        MovieDetailView(movie: selectedMovie,
                                        animation: animation)
                        
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .redacted(reason: moviesManager.movies.isEmpty ? .placeholder : [])
        }
        .background(Color.primaryBackground.ignoresSafeArea())
        .foregroundColor(.white.opacity(0.9))
        .onAppear(perform: moviesManager.getAllMovies)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    private func navTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 20, weight: .semibold, design: .monospaced))
            .lineLimit(1)
            .minimumScaleFactor(0.9)
            .truncationMode(.tail)
            .transition(.asymmetric(insertion: .fade(duration: 1.5), removal: .fade))
    }
    
    private var searchButton: some View {
        Button {
            // Search
        } label: {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
        }
    }
    
    private var leadingNavigationButton: some View {
        Button {
            withAnimation {
                selectedMovie = nil
            }
        } label: {
            if let _ = selectedMovie {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .frame(width: 25, height: 25)
            } else {
                Image(systemName: "line.horizontal.3.circle")
                    .imageScale(.large)
                    .frame(width: 25, height: 25)
            }
        }
        .transition(.asymmetric(insertion: .move(edge: .leading),
                                removal: .move(edge: .trailing)))
    }
}
