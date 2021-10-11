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
            menuButton
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
            .transition(.flipFromBottom)
    }
    
    private var searchButton: some View {
        Button {
            // Search
        } label: {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
        }
    }
    
    private var menuButton: some View {
        if let _ = selectedMovie {
            return Button {
                withAnimation {
                    print("Nil")
                    selectedMovie = nil
                }
            } label: {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
            }
            .transition(.asymmetric(insertion: .move(edge: .leading),
                                    removal: .move(edge: .trailing)))
        } else {
            return Button {
                // Menu
            } label: {
                Image(systemName: "line.horizontal.3.circle")
                    .imageScale(.large)
            }
            .transition(.asymmetric(insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
        }
    }
}
