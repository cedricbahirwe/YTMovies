//
//  MoviePreview.swift
//  PreMovie (iOS)
//
//  Created by Cédric Bahirwe on 10/10/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviePreview: View {
    init(of movie: Movie, size: CGSize, animation: Namespace.ID, onSelect: @escaping(Movie) -> ()) {
        self.movie = movie
        self.size = size
        self.animation = animation
        self.didSelect = onSelect
    }
    
    let movie: Movie
    let size: CGSize
    var animation: Namespace.ID
    var didSelect: (Movie) -> ()
    var body: some View {
        ZStack {
            WebImage(url: URL(string: movie.largeCoverImage))
                .resizable()
                .placeholder(Image("smoke"))
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
                        .scaledToFill()
                        .frame(maxWidth: size.width*0.8)
                        .clipped()
                        .shadow(radius: 10)
                        .matchedGeometryEffect(id: movie.largeCoverImage, in: animation)
                        .onTapGesture { didSelect(movie) }
                    
                    
                    Text(movie.rating.description)
                        .font(.title2.weight(.semibold))
                        .frame(width: 60, height: 60)
                        .background(Color.green)
                        .clipShape(Circle())
                        .offset(x: 30, y: 30)
                        .transition(.asymmetric(insertion: .move(edge: .leading),
                                                removal: .move(edge: .trailing)).combined(with: .opacity))
                }
                
                VStack {
                    Text(movie.title)
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.semibold)
                        .matchedGeometryEffect(id: movie.title, in: animation)
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

struct MoviePreview_Previews: PreviewProvider {
    @Namespace static var animate
    static var previews: some View {
        MoviePreview(of: .exampleMovie,
                     size: CGSize(width: 350, height: 600),
                     animation: animate) { _ in }
    }
}
