//
//  ContentView.swift
//  Shared
//
//  Created by Cédric Bahirwe on 09/10/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject
    private var moviesManager = MoviesManager()
    
    private let size = UIScreen.main.bounds.size
    
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
            GeometryReader { geo in

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        //                    ForEach(0..<10) { i in
                        ForEach(moviesManager.movies.isEmpty ? [.exampleMovie] : moviesManager.movies) { movie in
                            
                            MoviePreview(of: movie, size: geo.size)
                            
                        }
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
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
                        print(response.data.movies.first)
                    }
                case .failure(let error):
                    print(error.message)
                }
            }
            
    }
}


struct MoviePreview: View {
    init(of movie: Movie, size: CGSize) {
        self.movie = movie
        self.size = size
    }
    
    let movie: Movie
    let size: CGSize
    var body: some View {
        ZStack {
            WebImage(url: URL(string: movie.largeCoverImage))
                .resizable()
                .placeholder(Image("smoke"))
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: size.width)
                .clipped()
            //                                    .frame(width: geo.size.width)
            //                                    .frame(maxHeight: geo.size.height)
            //                                    .blur(radius: 5)
                .blur(radius: 4, opaque: false)
            
            VStack {
                ZStack(alignment: .topTrailing) {
                    WebImage(url: URL(string: movie.largeCoverImage))
                        .resizable()
                        .placeholder(Image("smoke"))
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(maxWidth: size.width*0.8)
                        .clipped()
                        .shadow(radius: 10)
                    
                    Text(movie.rating.description)
                        .font(.title2.weight(.semibold))
                        .frame(width: 60, height: 60)
                        .background(Color.green)
                        .clipShape(Circle())
                        .offset(x: 30, y: 30)
                    
                }
                
                VStack {
                    Text(movie.title)
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.semibold)
                    HStack {
                        Text(movie.mpaRating)
                        Text("1h 49 min")
                    }
                    .font(.system(.title2, design: .monospaced))
                    .foregroundColor(.gray)
                }
                .padding()
            }
            .padding(.top, 40)
        }
        .frame(width: size.width)
    }
}
